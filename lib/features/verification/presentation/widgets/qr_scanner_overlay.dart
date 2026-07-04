import 'package:flutter/material.dart';

import '../../../../design_system/colors/pokidoki_colors.dart';
import '../../../../design_system/spacing/pokidoki_spacing.dart';

/// Centered scanning frame with corner markers for the mock QR scanner.
class QrScannerOverlay extends StatelessWidget {
  const QrScannerOverlay({
    super.key,
    required this.size,
    this.onSimulateScan,
    this.semanticLabel,
  });

  final double size;
  final VoidCallback? onSimulateScan;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.pokidokiColors;
    return Semantics(
      button: onSimulateScan != null,
      label: semanticLabel,
      child: GestureDetector(
        onTap: onSimulateScan,
        child: SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _FramePainter(color: colors.primary),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(PokidokiSpacing.xl),
                child: Icon(
                  Icons.qr_code_2_rounded,
                  size: size * 0.28,
                  color: colors.primary.withValues(alpha: 0.35),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FramePainter extends CustomPainter {
  _FramePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const corner = 28.0;
    final rect = Offset.zero & size;

    // Top-left
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(corner, 0),
      paint,
    );
    canvas.drawLine(
      rect.topLeft,
      rect.topLeft + const Offset(0, corner),
      paint,
    );
    // Top-right
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(-corner, 0),
      paint,
    );
    canvas.drawLine(
      rect.topRight,
      rect.topRight + const Offset(0, corner),
      paint,
    );
    // Bottom-left
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(corner, 0),
      paint,
    );
    canvas.drawLine(
      rect.bottomLeft,
      rect.bottomLeft + const Offset(0, -corner),
      paint,
    );
    // Bottom-right
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + const Offset(-corner, 0),
      paint,
    );
    canvas.drawLine(
      rect.bottomRight,
      rect.bottomRight + const Offset(0, -corner),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _FramePainter oldDelegate) =>
      oldDelegate.color != color;
}
