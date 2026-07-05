import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user_profile.dart';
import '../../../data/repositories/user_repository.dart';
import '../../authentication/data/auth_providers.dart';
import '../domain/user_failure.dart';
import 'api/api_user_repository.dart';
import 'api/users_api.dart';

final usersApiProvider = Provider<UsersApi>((ref) {
  return UsersApi(ref.watch(apiClientProvider).dio);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return ApiUserRepository(
    usersApi: ref.watch(usersApiProvider),
    errorMapper: ref.watch(apiErrorMapperProvider),
  );
});

enum ProfileCompletionStatus { unknown, missing, complete }

class CurrentProfileState {
  const CurrentProfileState({
    this.profile,
    this.status = ProfileCompletionStatus.unknown,
    this.isLoading = false,
    this.errorMessageKey,
  });

  final UserProfile? profile;
  final ProfileCompletionStatus status;
  final bool isLoading;
  final String? errorMessageKey;

  CurrentProfileState copyWith({
    UserProfile? profile,
    ProfileCompletionStatus? status,
    bool? isLoading,
    String? errorMessageKey,
    bool clearError = false,
  }) {
    return CurrentProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      errorMessageKey: clearError
          ? null
          : (errorMessageKey ?? this.errorMessageKey),
    );
  }
}

class CurrentProfileController extends StateNotifier<CurrentProfileState> {
  CurrentProfileController(this._repository)
    : super(const CurrentProfileState());

  final UserRepository _repository;

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final profile = await _repository.getCurrentUser();
      state = CurrentProfileState(
        profile: profile,
        status: profile == null
            ? ProfileCompletionStatus.missing
            : ProfileCompletionStatus.complete,
        isLoading: false,
      );
    } on UserFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
        status: ProfileCompletionStatus.unknown,
      );
    }
  }

  Future<UserProfile?> createProfile({
    required String username,
    required String displayName,
    String? bio,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final profile = await _repository.createProfile(
        username: username,
        displayName: displayName,
        bio: bio,
      );
      state = CurrentProfileState(
        profile: profile,
        status: ProfileCompletionStatus.complete,
        isLoading: false,
      );
      return profile;
    } on UserFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
      );
      rethrow;
    }
  }

  Future<UserProfile?> updateProfile({
    String? displayName,
    String? bio,
    bool? isDiscoverable,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final profile = await _repository.updateProfile(
        displayName: displayName,
        bio: bio,
        isDiscoverable: isDiscoverable,
      );
      state = state.copyWith(
        profile: profile,
        status: ProfileCompletionStatus.complete,
        isLoading: false,
      );
      return profile;
    } on UserFailure catch (failure) {
      state = state.copyWith(
        isLoading: false,
        errorMessageKey: failure.messageKey,
      );
      rethrow;
    }
  }

  void clear() {
    state = const CurrentProfileState(status: ProfileCompletionStatus.missing);
  }
}

final currentProfileProvider =
    StateNotifierProvider<CurrentProfileController, CurrentProfileState>((ref) {
      return CurrentProfileController(ref.watch(userRepositoryProvider));
    });

final profileCompletionStatusProvider = Provider<ProfileCompletionStatus>((
  ref,
) {
  return ref.watch(currentProfileProvider).status;
});

final currentUserProvider = Provider<UserProfile?>((ref) {
  return ref.watch(currentProfileProvider).profile;
});
