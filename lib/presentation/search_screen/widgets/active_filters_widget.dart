import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class ActiveFiltersWidget extends StatelessWidget {
  final Map<String, dynamic> activeFilters;
  final Function(String) onRemoveFilter;

  const ActiveFiltersWidget({
    super.key,
    required this.activeFilters,
    required this.onRemoveFilter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filterChips = _buildFilterChips();

    if (filterChips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Filters',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 0.5.h,
            children: filterChips,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips() {
    final List<Widget> chips = [];

    // Date Range
    if (activeFilters['dateRange'] != null) {
      final dateRange = activeFilters['dateRange'] as DateTimeRange;
      chips.add(_buildFilterChip(
        'Date: ${dateRange.start.month}/${dateRange.start.day} - ${dateRange.end.month}/${dateRange.end.day}',
        'dateRange',
      ));
    }

    // Price Range
    if (activeFilters['priceRange'] != null) {
      final priceRange = activeFilters['priceRange'] as RangeValues;
      if (priceRange.start > 0 || priceRange.end < 1000) {
        chips.add(_buildFilterChip(
          'Price: \$${priceRange.start.round()}-\$${priceRange.end.round()}',
          'priceRange',
        ));
      }
    }

    // Location Radius
    if (activeFilters['locationRadius'] != null) {
      final radius = activeFilters['locationRadius'] as double;
      if (radius != 25) {
        chips.add(_buildFilterChip(
          'Radius: ${radius.round()} miles',
          'locationRadius',
        ));
      }
    }

    // Categories
    if (activeFilters['categories'] != null) {
      final categories = activeFilters['categories'] as List<String>;
      for (final category in categories) {
        chips.add(_buildFilterChip(category, 'category_$category'));
      }
    }

    // Verified Sellers
    if (activeFilters['verifiedOnly'] == true) {
      chips.add(_buildFilterChip('Verified Only', 'verifiedOnly'));
    }

    return chips;
  }

  Widget _buildFilterChip(String label, String filterKey) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);

        return Chip(
          label: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontSize: 10.sp,
            ),
          ),
          deleteIcon: CustomIconWidget(
            iconName: 'close',
            color: theme.colorScheme.primary,
            size: 14,
          ),
          onDeleted: () => onRemoveFilter(filterKey),
          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          side: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}
