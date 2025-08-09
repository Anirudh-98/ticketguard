import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EventInfoSectionWidget extends StatelessWidget {
  final String? eventName;
  final String? eventDate;
  final String? eventTime;
  final String? venue;

  const EventInfoSectionWidget({
    super.key,
    this.eventName,
    this.eventDate,
    this.eventTime,
    this.venue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event title
          Text(
            eventName ?? 'Event Name',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),

          // Date and time
          Row(
            children: [
              CustomIconWidget(
                iconName: 'calendar_today',
                color: AppTheme.primaryBlue,
                size: 20,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventDate ?? 'Event Date',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (eventTime != null) ...[
                      SizedBox(height: 0.5.h),
                      Text(
                        eventTime!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),

          // Venue location
          Row(
            children: [
              CustomIconWidget(
                iconName: 'location_on',
                color: AppTheme.primaryBlue,
                size: 20,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  venue ?? 'Venue Location',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
