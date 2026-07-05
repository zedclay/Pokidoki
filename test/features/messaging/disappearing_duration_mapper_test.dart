import 'package:flutter_test/flutter_test.dart';
import 'package:pokidoki/features/messaging/domain/disappearing_duration_mapper.dart';

void main() {
  group('DisappearingDurationMapper', () {
    test('maps UI hours to backend seconds', () {
      expect(DisappearingDurationMapper.hoursToSeconds(null), 0);
      expect(DisappearingDurationMapper.hoursToSeconds(1), 3600);
      expect(DisappearingDurationMapper.hoursToSeconds(24), 86400);
      expect(DisappearingDurationMapper.hoursToSeconds(168), 604800);
    });

    test('maps backend seconds to UI hours', () {
      expect(DisappearingDurationMapper.secondsToHours(0), isNull);
      expect(DisappearingDurationMapper.secondsToHours(null), isNull);
      expect(DisappearingDurationMapper.secondsToHours(3600), 1);
      expect(DisappearingDurationMapper.secondsToHours(86400), 24);
      expect(DisappearingDurationMapper.secondsToHours(604800), 168);
    });

    test('rejects unsupported hour values', () {
      expect(
        () => DisappearingDurationMapper.hoursToSeconds(12),
        throwsArgumentError,
      );
    });
  });
}
