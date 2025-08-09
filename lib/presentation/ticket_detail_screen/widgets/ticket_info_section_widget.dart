import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TicketInfoSectionWidget extends StatelessWidget {
  final String? section;
  final String? row;
  final String? seat;
  final int? quantity;
  final String? currentPrice;
  final String? originalPrice;
  final bool isDiscounted;

  const TicketInfoSectionWidget({
    super.key,
    this.section,
    this.row,
    this.seat,
    this.quantity,
    this.currentPrice,
    this.originalPrice,
    this.isDiscounted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
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
            'Ticket Details',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),

          // Seat information
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildDetailItem(
                  context,
                  'Section',
                  section ?? 'N/A',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildDetailItem(
                  context,
                  'Row',
                  row ?? 'N/A',
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildDetailItem(
                  context,
                  'Seats',
                  seat ?? 'N/A',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildDetailItem(
                  context,
                  'Quantity',
                  '${quantity ?? 0} ticket${(quantity ?? 0) != 1 ? 's' : ''}',
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Price section
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price per ticket',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (isDiscounted && originalPrice != null) ...[
                      SizedBox(height: 0.5.h),
                      Text(
                        originalPrice!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  currentPrice ?? '\$0',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
