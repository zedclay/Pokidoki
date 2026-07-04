import 'package:flutter/widgets.dart';

/// Returns true when the platform requests reduced motion.
bool prefersReducedMotion(BuildContext context) {
  return MediaQuery.maybeOf(context)?.disableAnimations ?? false;
}

/// Duration that collapses to zero when reduced motion is preferred.
Duration motionDuration(
  BuildContext context,
  Duration preferred, {
  Duration reduced = Duration.zero,
}) {
  return prefersReducedMotion(context) ? reduced : preferred;
}
