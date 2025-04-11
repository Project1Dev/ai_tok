import 'package:flutter/material.dart';
import '../config/theme_constants.dart';

class ShimmerEffect extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const ShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<ShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.shimmerDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              colors: AppColors.shimmerGradient.colors,
              stops: AppColors.shimmerGradient.stops,
              begin: AppColors.shimmerGradient.begin,
              end: AppColors.shimmerGradient.end,
              transform: _ShimmerGradientTransform(
                _controller.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ShimmerGradientTransform extends GradientTransform {
  const _ShimmerGradientTransform(this.value);

  final double value;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (value * 2 - 1), 0.0, 0.0);
  }
}
