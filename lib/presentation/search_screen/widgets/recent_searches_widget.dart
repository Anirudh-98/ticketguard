import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<String> recentSearches;
  final Function(String) onSearchTap;
  final Function(String) onRemoveSearch;

  const RecentSearchesWidget({
    super.key,
    required this.recentSearches,
    required this.onSearchTap,
    required this.onRemoveSearch,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (recentSearches.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Text(
            'Recent Searches',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 6.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              final search = recentSearches[index];
              return Container(
                margin: EdgeInsets.only(right: 2.w),
                child: Chip(
                  label: Text(
                    search,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  deleteIcon: CustomIconWidget(
                    iconName: 'close',
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 16,
                  ),
                  onDeleted: () => onRemoveSearch(search),
                  backgroundColor: theme.colorScheme.surface,
                  side: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
