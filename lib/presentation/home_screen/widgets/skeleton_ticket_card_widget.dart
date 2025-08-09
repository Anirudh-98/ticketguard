import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class SkeletonTicketCardWidget extends StatefulWidget {
  const SkeletonTicketCardWidget({super.key});

  @override
  State<SkeletonTicketCardWidget> createState() =>
      _SkeletonTicketCardWidgetState();
}

class _SkeletonTicketCardWidgetState extends State<SkeletonTicketCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonImage(),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSkeletonTitle(),
                SizedBox(height: 1.h),
                _buildSkeletonDetails(),
                SizedBox(height: 1.5.h),
                _buildSkeletonPriceRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonImage() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          height: 20.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralGray.withValues(alpha: _animation.value),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonTitle() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 70.w,
          height: 2.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralGray.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonDetails() {
    return Column(
      children: [
        _buildSkeletonRow(50.w),
        SizedBox(height: 0.5.h),
        _buildSkeletonRow(60.w),
      ],
    );
  }

  Widget _buildSkeletonRow(double width) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: width,
          height: 1.5.h,
          decoration: BoxDecoration(
            color: AppTheme.neutralGray.withValues(alpha: _animation.value),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonPriceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 20.w,
              height: 2.5.h,
              decoration: BoxDecoration(
                color: AppTheme.neutralGray.withValues(alpha: _animation.value),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: 25.w,
              height: 1.5.h,
              decoration: BoxDecoration(
                color: AppTheme.neutralGray.withValues(alpha: _animation.value),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          },
        ),
      ],
    );
  }
}
