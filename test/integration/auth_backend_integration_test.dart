import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'register verify login me refresh logout',
    () {
      // Manual workflow documented in docs/LOCAL_BACKEND_CONNECTIVITY.md.
    },
    skip: 'Requires local backend, PostgreSQL, and ALLOW_DEV_AUTH_CODE',
  );
}
