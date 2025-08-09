import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepTitles;

  const ProgressIndicatorWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppTheme.pureWhite,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Step Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Step ${currentStep + 1} of $totalSteps',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Progress Bar
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              final isUpcoming = index > currentStep;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 0.5.h,
                        decoration: BoxDecoration(
                          color: isCompleted || isCurrent
                              ? AppTheme.primaryBlue
                              : AppTheme.borderSubtle,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    if (index < totalSteps - 1) SizedBox(width: 1.w),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 2.h),

          // Step Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              final isUpcoming = index > currentStep;

              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppTheme.verificationGreen
                            : isCurrent
                                ? AppTheme.primaryBlue
                                : AppTheme.neutralGray,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: isCompleted
                              ? AppTheme.verificationGreen
                              : isCurrent
                                  ? AppTheme.primaryBlue
                                  : AppTheme.borderSubtle,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isCompleted
                            ? CustomIconWidget(
                                iconName: 'check',
                                color: AppTheme.pureWhite,
                                size: 16,
                              )
                            : Text(
                                '${index + 1}',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  color: isCurrent
                                      ? AppTheme.pureWhite
                                      : isUpcoming
                                          ? AppTheme.textSecondary
                                          : AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      stepTitles[index],
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: isCompleted || isCurrent
                            ? AppTheme.textPrimary
                            : AppTheme.textSecondary,
                        fontWeight:
                            isCurrent ? FontWeight.w600 : FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
