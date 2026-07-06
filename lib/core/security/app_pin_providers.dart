import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_pin_storage.dart';

final appPinStorageProvider = Provider<AppPinStorage>((ref) {
  return SecureAppPinStorage();
});
