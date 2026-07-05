import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/mock/mock_contacts_repository.dart';
import '../../../data/repositories/contacts_repository.dart';
import '../../authentication/data/auth_providers.dart';
import 'api/api_contacts_repository.dart';
import 'api/contacts_api.dart';

final contactsApiProvider = Provider<ContactsApi>((ref) {
  return ContactsApi(ref.watch(apiClientProvider).dio);
});

final contactsRepositoryProvider = Provider<ContactsRepository>((ref) {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return MockContactsRepository();
  }

  return ApiContactsRepository(
    contactsApi: ref.watch(contactsApiProvider),
    errorMapper: ref.watch(apiErrorMapperProvider),
  );
});
