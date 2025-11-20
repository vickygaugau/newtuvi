import 'dart:math';
import 'package:flutter/material.dart';

class DustyImage extends StatefulWidget {
  final Widget child;
  final double width;
  final double height;
  final int particleCount;
  final double radius;
  final double speed;
  final double intensity;

  const DustyImage({
    super.key,
    required this.child,
    this.width = 100,
    this.height = 100,
    this.particleCount = 30,
    this.radius = 20.0,
    this.speed = 0.5,
    this.intensity = 1.0,
  });

  @override
  State<DustyImage> createState() => _DustyImageState();
}

class _DustyImageState extends State<DustyImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_DustParticle> _particles;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    final rnd = Random();
    _particles = List.generate(widget.particleCount, (_) {
      return _DustParticle(
        angle: rnd.nextDouble() * 2 * pi,
        radiusOffset: rnd.nextDouble() * 0.5 + 0.5,
        size: 1.0 + rnd.nextDouble() * 2.0,
        opacity: 0.3 + rnd.nextDouble() * 0.4,
      );
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          final animationValue = _ctrl.value; // luôn != null
          return CustomPaint(
            painter: _DustPainter(
              particles: _particles,
              animationValue: animationValue,
              intensity: widget.intensity,
              radius: widget.radius,
              speed: widget.speed,
            ),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class _DustParticle {
  final double angle;
  final double radiusOffset;
  final double size;
  final double opacity;

  _DustParticle({
    required this.angle,
    required this.radiusOffset,
    required this.size,
    required this.opacity,
  });
}

class _DustPainter extends CustomPainter {
  final List<_DustParticle> particles;
  final double animationValue;
  final double intensity;
  final double radius;
  final double speed;

  _DustPainter({
    required this.particles,
    required this.animationValue,
    required this.intensity,
    required this.radius,
    required this.speed,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final paint = Paint()..color = Colors.white;

    for (final p in particles) {
      final angle = (p.angle ?? 0.0) + (animationValue) * speed * 2 * pi;
      final r = (p.radiusOffset ?? 1.0) * radius;
      final x = cx + cos(angle) * r;
      final y = cy + sin(angle) * r;
      paint.color = Colors.white.withOpacity((p.opacity ?? 0.3) * intensity);
      canvas.drawCircle(Offset(x, y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DustPainter oldDelegate) => true;
}
