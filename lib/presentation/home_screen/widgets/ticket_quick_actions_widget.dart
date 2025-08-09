import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TicketQuickActionsWidget extends StatelessWidget {
  final VoidCallback? onSave;
  final VoidCallback? onShare;
  final VoidCallback? onReport;

  const TicketQuickActionsWidget({
    super.key,
    this.onSave,
    this.onShare,
    this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildActionButton(
            context: context,
            icon: 'bookmark_border',
            label: 'Save',
            onTap: onSave,
          ),
          SizedBox(width: 4.w),
          _buildActionButton(
            context: context,
            icon: 'share',
            label: 'Share',
            onTap: onShare,
          ),
          SizedBox(width: 4.w),
          _buildActionButton(
            context: context,
            icon: 'flag',
            label: 'Report',
            onTap: onReport,
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String icon,
    required String label,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final color = isDestructive ? AppTheme.errorRed : theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: color,
              size: 20,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
