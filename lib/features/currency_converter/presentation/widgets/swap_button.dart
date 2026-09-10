import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwapButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SwapButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<SwapButton> createState() => _SwapButtonState();
}

class _SwapButtonState extends State<SwapButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 52.w,
        height: 52.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(0xffD9E2EC),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff172033).withValues(alpha: 0.06),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: RotationTransition(
          turns: Tween<double>(
            begin: 0,
            end: 0.5,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
          ),
          child: Icon(
            Icons.swap_vert_rounded,
            size: 26.sp,
            color: Color(0xff3B82F6),
          ),
        ),
      ),
    );
  }
}