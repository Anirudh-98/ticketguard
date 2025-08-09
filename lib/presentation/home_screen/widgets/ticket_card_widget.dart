import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TicketCardWidget extends StatelessWidget {
  final Map<String, dynamic> ticketData;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const TicketCardWidget({
    super.key,
    required this.ticketData,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
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
            _buildEventImage(context),
            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEventTitle(context),
                  SizedBox(height: 1.h),
                  _buildEventDetails(context),
                  SizedBox(height: 1.5.h),
                  _buildPriceAndSeller(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Stack(
        children: [
          CustomImageWidget(
            imageUrl: (ticketData['eventImage'] as String?) ?? '',
            width: double.infinity,
            height: 20.h,
            fit: BoxFit.cover,
          ),
          if ((ticketData['isFeatured'] as bool?) == true)
            Positioned(
              top: 2.w,
              left: 2.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.warningYellow,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Featured',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventTitle(BuildContext context) {
    return Text(
      (ticketData['eventName'] as String?) ?? 'Event Name',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: 'calendar_today',
              color: theme.colorScheme.onSurfaceVariant,
              size: 16,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                (ticketData['eventDate'] as String?) ?? 'Event Date',
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        Row(
          children: [
            CustomIconWidget(
              iconName: 'location_on',
              color: theme.colorScheme.onSurfaceVariant,
              size: 16,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                (ticketData['location'] as String?) ?? 'Location',
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceAndSeller(BuildContext context) {
    final theme = Theme.of(context);
    final isVerified = (ticketData['isSellerVerified'] as bool?) ?? false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          (ticketData['price'] as String?) ?? '\$0',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            if (isVerified) ...[
              CustomIconWidget(
                iconName: 'verified',
                color: AppTheme.verificationGreen,
                size: 16,
              ),
              SizedBox(width: 1.w),
            ],
            Text(
              (ticketData['sellerName'] as String?) ?? 'Seller',
              style: theme.textTheme.bodySmall?.copyWith(
                color: isVerified
                    ? AppTheme.verificationGreen
                    : theme.colorScheme.onSurfaceVariant,
                fontWeight: isVerified ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
