import 'package:flutter/material.dart';
import '../styles/colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(red),
      ),
    );
  }
}


const double pi = 3.1415926535897932;


class GradiantLoadingIndicatorWidget extends StatefulWidget {
  const GradiantLoadingIndicatorWidget({super.key});

  @override
  State<GradiantLoadingIndicatorWidget> createState() => _GradiantLoadingIndicatorWidgetState();
}

class _GradiantLoadingIndicatorWidgetState extends State<GradiantLoadingIndicatorWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: CustomPaint(
          size: const Size(75, 75),
          painter: GradientCirclePainter(),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GradientCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: 2 * pi,
      colors: [
        Color(0xFFD8042A),
        Color(0x00D8042A), // Transparent color for fading out
      ],
    );

    final Paint paint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2))
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final Offset center = size.center(Offset.zero);

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}