import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SellerInfoSectionWidget extends StatelessWidget {
  final String? sellerName;
  final String? sellerImage;
  final bool isVerified;
  final double? rating;
  final String? memberSince;
  final String? responseTime;
  final int? successfulSales;

  const SellerInfoSectionWidget({
    super.key,
    this.sellerName,
    this.sellerImage,
    this.isVerified = false,
    this.rating,
    this.memberSince,
    this.responseTime,
    this.successfulSales,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
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
          Text(
            'Seller Information',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Seller profile section
          Row(
            children: [
              // Profile image
              Container(
                width: 15.w,
                height: 15.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CustomImageWidget(
                    imageUrl: sellerImage ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 4.w),

              // Seller details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          sellerName ?? 'Seller Name',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (isVerified) ...[
                          SizedBox(width: 2.w),
                          Container(
                            padding: EdgeInsets.all(0.5.w),
                            decoration: BoxDecoration(
                              color: AppTheme.verificationGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: CustomIconWidget(
                              iconName: 'check',
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 0.5.h),

                    // Rating
                    if (rating != null)
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return CustomIconWidget(
                              iconName: 'star',
                              color: index < rating!.floor()
                                  ? AppTheme.warningYellow
                                  : theme.colorScheme.outline,
                              size: 16,
                            );
                          }),
                          SizedBox(width: 2.w),
                          Text(
                            rating!.toStringAsFixed(1),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                    if (memberSince != null) ...[
                      SizedBox(height: 0.5.h),
                      Text(
                        'Member since $memberSince',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Trust indicators
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.verificationGreen.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.verificationGreen.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                if (responseTime != null)
                  _buildTrustIndicator(
                    context,
                    'schedule',
                    'Response Time',
                    responseTime!,
                  ),
                if (successfulSales != null) ...[
                  SizedBox(height: 1.h),
                  _buildTrustIndicator(
                    context,
                    'verified_user',
                    'Successful Sales',
                    '$successfulSales transactions',
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustIndicator(
    BuildContext context,
    String iconName,
    String label,
    String value,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.verificationGreen,
          size: 18,
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
