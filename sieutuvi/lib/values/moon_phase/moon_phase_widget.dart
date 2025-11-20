import 'dart:math';
import 'package:flutter/material.dart';

class EnhancedMoonPhaseWidget extends StatefulWidget {
  final double fraction;
  final double size;
  final Duration duration;
  final double sunAngle;
  final bool enable3D;
  final bool showDust;
  final double rotationSpeed;

  const EnhancedMoonPhaseWidget({
    super.key,
    required this.fraction,
    this.size = 150,
    this.duration = const Duration(milliseconds: 900),
    this.sunAngle = 0.0,
    this.enable3D = true,
    this.showDust = true,
    this.rotationSpeed = 0.2,
  }) : assert(fraction >= 0 && fraction <= 1);

  @override
  State<EnhancedMoonPhaseWidget> createState() =>
      _EnhancedMoonPhaseWidgetState();
}

class _EnhancedMoonPainter extends CustomPainter {
  final double fraction;
  final double sunAngle;
  final double rotationAngle;
  final bool enable3D;
  final bool showDust;

  _EnhancedMoonPainter({
    required this.fraction,
    required this.sunAngle,
    required this.rotationAngle,
    required this.enable3D,
    required this.showDust,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = min(size.width, size.height) / 2;
    final Paint paint = Paint()..isAntiAlias = true;

    canvas.save();
    canvas.translate(cx, cy);
    canvas.rotate(rotationAngle);
    canvas.translate(-cx, -cy);

    final moonCenter = Offset(cx, cy);
    final moonRect = Rect.fromCircle(center: moonCenter, radius: radius);
    final Path moonPath = Path()..addOval(moonRect);

    double f = fraction % 1.0;
    double angle = 2 * pi * f;
    double d = cos(angle);
    double offset = d * radius;
    final Path shadowCircle = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(cx + offset, cy), radius: radius),
      );
    final Path intersect = Path.combine(
      PathOperation.intersect,
      moonPath,
      shadowCircle,
    );
    final Path illuminated = Path.combine(
      PathOperation.difference,
      moonPath,
      intersect,
    );

    final lightDx = cos(sunAngle) * 0.35 * radius;
    final lightDy = sin(sunAngle) * 0.35 * radius;
    final Offset lightCenter = Offset(cx + lightDx, cy + lightDy);

    // Gradient sáng hơn
    final Gradient litGrad = RadialGradient(
      center: Alignment(
        (lightCenter.dx - cx) / radius,
        (lightCenter.dy - cy) / radius,
      ),
      radius: 0.95,
      colors: [Color(0xFFFFFFE7), Color(0xFFFFF3C6), Color(0xFFFFFFFF)],
      stops: [0.0, 0.6, 1.0],
    );

    paint.shader = litGrad.createShader(moonRect);
    canvas.drawPath(illuminated, paint);

    if (enable3D) {
      final Paint innerShadow = Paint()
        ..shader = RadialGradient(
          center: Alignment((cx - (cx + offset)) / radius, 0),
          radius: 1.0,
          colors: [
            Colors.black.withOpacity(0.35),
            Colors.black.withOpacity(0.05),
          ],
          stops: [0.0, 1.0],
        ).createShader(moonRect)
        ..blendMode = BlendMode.dstIn;
      canvas.drawPath(moonPath, innerShadow);

      final Path spec = Path();
      spec.addArc(
        Rect.fromCircle(center: lightCenter, radius: radius * 0.9),
        sunAngle - 0.6,
        1.2,
      );
      final Paint specPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius * 0.015
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.03)
        ..color = Colors.white.withOpacity(0.18);
      canvas.drawPath(spec, specPaint);
    }

    // Shadow phần tối với transparency
    final Path remainingShadow = Path.combine(
      PathOperation.difference,
      moonPath,
      illuminated,
    );
    final Paint shadowPaint = Paint()
      ..color = Color(0x88000000); // 50% transparent
    canvas.drawPath(remainingShadow, shadowPaint);

    // Rim light
    final Paint rim = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.04
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.07)
      ..color = Colors.white.withOpacity(0.14);
    canvas.drawPath(moonPath, rim);

    // Dust particles trên bề mặt
    if (showDust) {
      final double closenessToFull = 1.0 - ((f - 0.5).abs() / 0.5);
      if (closenessToFull > 0.3) {
        // hạt bụi xuất hiện kể cả gần trăng tròn
        _drawDust(canvas, cx, cy, radius, closenessToFull);
      }
    }

    _drawEnhancedSurface(canvas, cx, cy, radius);
    canvas.restore();
  }

  void _drawDust(
    Canvas canvas,
    double cx,
    double cy,
    double radius,
    double intensity,
  ) {
    final rnd = Random(123);
    final Paint p = Paint()..isAntiAlias = true;
    final int count = (30 * intensity).ceil();
    for (int i = 0; i < count; i++) {
      final ang = rnd.nextDouble() * pi * 2;
      final r = radius * (0.98 + rnd.nextDouble() * 0.08);
      final pos = Offset(cx + cos(ang) * r, cy + sin(ang) * r);
      final size = (1.0 + rnd.nextDouble() * 2.5) * (intensity * 1.2);
      p.color = Colors.white.withOpacity(
        0.35 * intensity * (0.6 + rnd.nextDouble() * 0.4),
      );
      canvas.drawCircle(pos, size, p);
    }
  }

  void _drawEnhancedSurface(
    Canvas canvas,
    double cx,
    double cy,
    double radius,
  ) {
    final rnd = Random(42);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = max(0.35, radius * 0.005)
      ..color = Colors.black.withOpacity(0.05)
      ..isAntiAlias = true;
    for (int i = 0; i < 10; i++) {
      final r = radius * (0.25 + rnd.nextDouble() * 0.6);
      final ang = rnd.nextDouble() * pi * 2;
      final start = ang;
      final sweep = 0.2 + rnd.nextDouble() * 0.7;
      final rect = Rect.fromCircle(
        center: Offset(
          cx + cos(ang) * 0.1 * radius,
          cy + sin(ang) * 0.1 * radius,
        ),
        radius: r,
      );
      canvas.drawArc(rect, start, sweep, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _EnhancedMoonPainter oldDelegate) {
    return oldDelegate.fraction != fraction ||
        oldDelegate.sunAngle != sunAngle ||
        oldDelegate.rotationAngle != rotationAngle ||
        oldDelegate.enable3D != enable3D ||
        oldDelegate.showDust != showDust;
  }
}

class _EnhancedMoonPhaseWidgetState extends State<EnhancedMoonPhaseWidget>
    with TickerProviderStateMixin {
  late AnimationController _phaseCtrl;
  late Animation<double> _phaseAnim;
  late AnimationController _rotationCtrl;
  double _prevFraction = 0.0;

  @override
  void initState() {
    super.initState();
    _prevFraction = widget.fraction;
    _phaseCtrl = AnimationController(vsync: this, duration: widget.duration);
    _phaseAnim = Tween<double>(
      begin: widget.fraction,
      end: widget.fraction,
    ).animate(CurvedAnimation(parent: _phaseCtrl, curve: Curves.easeInOut));

    _rotationCtrl = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant EnhancedMoonPhaseWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.fraction - _prevFraction).abs() > 1e-6) {
      _phaseCtrl.duration = widget.duration;
      _phaseAnim = Tween<double>(
        begin: _prevFraction,
        end: widget.fraction,
      ).animate(CurvedAnimation(parent: _phaseCtrl, curve: Curves.easeInOut));
      _prevFraction = widget.fraction;
      _phaseCtrl
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _phaseCtrl.dispose();
    _rotationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_phaseAnim, _rotationCtrl]),
        builder: (context, child) {
          final rotationAngle = _rotationCtrl.lastElapsedDuration != null
              ? (_rotationCtrl.lastElapsedDuration!.inMilliseconds / 1000.0) *
                    widget.rotationSpeed
              : 0.0;

          return CustomPaint(
            painter: _EnhancedMoonPainter(
              fraction: _phaseAnim.value,
              sunAngle: widget.sunAngle,
              rotationAngle: rotationAngle,
              enable3D: widget.enable3D,
              showDust: widget.showDust,
            ),
            size: Size(widget.size, widget.size),
          );
        },
      ),
    );
  }
}

/// Convenience factory hooking date -> enhanced widget
Widget buildEnhancedAnimatedMoonFromDate(
  DateTime date, {
  double sunAngle = 0.0,
  double size = 70,
}) {
  final fraction = moonPhaseFraction(date);
  return EnhancedMoonPhaseWidget(
    fraction: fraction,
    size: size,
    sunAngle: sunAngle,
    enable3D: true,
    showDust: true,
    rotationSpeed: 0.08,
  );
}

double moonPhaseFraction(DateTime date) {
  // Chuyển sang UTC để chính xác hơn
  final utc = date.toUtc();

  // Julian Day Number (JDN)
  final year = utc.year;
  final month = utc.month;
  final day =
      utc.day + (utc.hour / 24) + (utc.minute / 1440) + (utc.second / 86400);

  int a = ((14 - month) / 12).floor();
  int y = year + 4800 - a;
  int m = month + 12 * a - 3;

  double JDN =
      day +
      ((153 * m + 2) / 5).floor() +
      365 * y +
      (y / 4).floor() -
      (y / 100).floor() +
      (y / 400).floor() -
      32045;

  // Known new moon reference (Jan 6, 2000 18:14 UTC)
  const double knownNewMoon = 2451550.1;

  // Chu kỳ mặt trăng (synodic month)
  const double synodicMonth = 29.530588853;

  // Age = số ngày từ lần trăng non gần nhất
  double age = (JDN - knownNewMoon) % synodicMonth;
  if (age < 0) age += synodicMonth;

  // Fraction từ 0 → 1
  return age / synodicMonth;
}
