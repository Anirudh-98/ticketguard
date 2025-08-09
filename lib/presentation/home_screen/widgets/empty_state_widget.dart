import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback? onResetFilters;

  const EmptyStateWidget({
    super.key,
    this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15.w),
              ),
              child: CustomIconWidget(
                iconName: 'confirmation_number',
                color: theme.colorScheme.primary,
                size: 15.w,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'No Tickets Found',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'We couldn\'t find any tickets matching your criteria. Try adjusting your filters or check back later for new listings.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            if (onResetFilters != null)
              ElevatedButton(
                onPressed: onResetFilters,
                child: const Text('Reset Filters'),
              ),
          ],
        ),
      ),
    );
  }
}
