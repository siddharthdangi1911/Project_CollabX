import 'package:flutter/material.dart';

class LoginLogoAnimation extends StatefulWidget {
  final Icon icon;
  final Duration upDuration;
  final Duration rotationDuration;
  final Duration scaleDuration;

  final double maxPos;
  final double minPos;

  final double maxScale;
  final double minScale;

  final bool startMoveUp; // movement + scaling trigger

  const LoginLogoAnimation({
    super.key,
    required this.icon,
    required this.startMoveUp,
    required this.upDuration,
    required this.rotationDuration,
    required this.scaleDuration,
    this.minPos = 80,
    this.maxPos = 200,
    this.maxScale = 1.7,
    this.minScale = 1.0,
  });

  @override
  State<LoginLogoAnimation> createState() => _LoginLogoAnimationState();
}

class _LoginLogoAnimationState extends State<LoginLogoAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.upDuration,
      curve: Curves.easeInOut,
      top: widget.startMoveUp ? widget.minPos : widget.maxPos,
      left: 0,
      right: 0,
      child: Center(
        child: AnimatedScale(
          scale: widget.startMoveUp ? widget.maxScale : widget.minScale,
          duration: widget.scaleDuration,
          child: RotationTransition(
            turns: rotationController,
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
