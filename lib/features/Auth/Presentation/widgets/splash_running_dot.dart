import 'package:flutter/material.dart';

class SplashRunningDot extends StatefulWidget {
  const SplashRunningDot({super.key, required this.index, required this.currentPage});

  final int index;
  final int currentPage;

  @override
  State<SplashRunningDot> createState() => _SplashRunningDot();
}

class _SplashRunningDot extends State<SplashRunningDot> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      margin: const EdgeInsets.only(left: 6),
      height: 6,
      width: widget.currentPage == widget.index ? 20 : 6,
      decoration: BoxDecoration(
        color: widget.currentPage == widget.index ? Colors.blue[600] : Colors.blue[300],
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
