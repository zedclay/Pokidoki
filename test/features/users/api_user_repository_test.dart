import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/core/network/api_error_mapper.dart';
import 'package:pokidoki/features/users/data/api/api_user_repository.dart';
import 'package:pokidoki/features/users/data/api/users_api.dart';

void main() {
  test('maps username availability response', () async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost/api/v1',
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.path.contains('username-availability')) {
            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 200,
                data: {'username': 'hafid', 'available': true},
              ),
            );
            return;
          }
          handler.next(options);
        },
      ),
    );

    final repository = ApiUserRepository(
      usersApi: UsersApi(dio),
      errorMapper: const ApiErrorMapper(),
    );

    final result = await repository.checkUsernameAvailability('hafid');
    expect(result.available, isTrue);
    expect(result.username, 'hafid');
  });
}
