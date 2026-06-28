import 'dart:math' as math;
import 'package:flutter/material.dart';

// --- 1. DATA MODEL ---
class StarData {
  final double top;      // Percentage (0.0 to 1.0)
  final double left;     // Percentage (0.0 to 1.0)
  final double size;     // Pixel size
  final int duration;    // Animation speed in ms

  StarData({
    required this.top,
    required this.left,
    required this.size,
    required this.duration,
  });
}

// --- 2. HELPER FUNCTION (Generates the List) ---
// Call this in your Controller's onInit()
List<StarData> generateStarBackground({int count = 70}) {
  final List<StarData> stars = [];
  final random = math.Random();

  for (int i = 0; i < count; i++) {
    stars.add(StarData(
      top: random.nextDouble(),
      left: random.nextDouble(),
      // Size: Random between 4.0 and 10.0 (Adjust as needed)
      size: random.nextDouble() * 6 + 4,
      // Speed: Random between 1s and 3s
      duration: random.nextInt(2000) + 1000,
    ));
  }
  return stars;
}

// --- 3. THE WIDGET ---
class BlinkingStar extends StatefulWidget {
  final double top;
  final double left;
  final double size;
  final int duration;

  const BlinkingStar({
    super.key,
    required this.top,
    required this.left,
    required this.size,
    required this.duration,
  });

  @override
  State<BlinkingStar> createState() => _BlinkingStarState();
}

class _BlinkingStarState extends State<BlinkingStar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    // Animate opacity
    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Random start delay
    Future.delayed(Duration(milliseconds: math.Random().nextInt(1000)), () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ FIX: WRAP IN POSITIONED
    // Without this, the Stack doesn't know where to put the star!
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: StarFlarePainter(
                color: Colors.white.withOpacity(0.7), // Increased opacity slightly
                glowOpacity: 0.4,
              ),
            ),
          );
        },
      ),
    );
  }
}

// --- 4. THE PAINTER (Draws the ✨ shape) ---
class StarFlarePainter extends CustomPainter {
  final Color color;
  final double glowOpacity;

  StarFlarePainter({required this.color, required this.glowOpacity});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color..style = PaintingStyle.fill;

    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double r = size.width / 2;

    // Draw Diamond/Flare shape
    final Path path = Path();
    path.moveTo(cx, cy - r);
    path.quadraticBezierTo(cx + (r * 0.1), cy - (r * 0.1), cx + r, cy);
    path.quadraticBezierTo(cx + (r * 0.1), cy + (r * 0.1), cx, cy + r);
    path.quadraticBezierTo(cx - (r * 0.1), cy + (r * 0.1), cx - r, cy);
    path.quadraticBezierTo(cx - (r * 0.1), cy - (r * 0.1), cx, cy - r);
    path.close();

    // Glow
    final Paint glowPaint = Paint()
      ..color = color.withOpacity(glowOpacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}