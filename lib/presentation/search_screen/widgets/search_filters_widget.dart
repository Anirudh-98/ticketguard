import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SearchFiltersWidget extends StatefulWidget {
  final Map<String, dynamic> activeFilters;
  final Function(Map<String, dynamic>) onFiltersChanged;

  const SearchFiltersWidget({
    super.key,
    required this.activeFilters,
    required this.onFiltersChanged,
  });

  @override
  State<SearchFiltersWidget> createState() => _SearchFiltersWidgetState();
}

class _SearchFiltersWidgetState extends State<SearchFiltersWidget> {
  late Map<String, dynamic> _filters;
  DateTimeRange? _dateRange;
  RangeValues _priceRange = const RangeValues(0, 1000);
  double _locationRadius = 25;
  List<String> _selectedCategories = [];
  bool _verifiedSellersOnly = false;

  final List<String> _categories = [
    'Concerts',
    'Sports',
    'Theater',
    'Comedy',
    'Festivals',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.activeFilters);
    _initializeFilters();
  }

  void _initializeFilters() {
    _dateRange = _filters['dateRange'] as DateTimeRange?;
    _priceRange =
        _filters['priceRange'] as RangeValues? ?? const RangeValues(0, 1000);
    _locationRadius = _filters['locationRadius'] as double? ?? 25;
    _selectedCategories = List<String>.from(_filters['categories'] ?? []);
    _verifiedSellersOnly = _filters['verifiedOnly'] as bool? ?? false;
  }

  void _updateFilters() {
    _filters = {
      'dateRange': _dateRange,
      'priceRange': _priceRange,
      'locationRadius': _locationRadius,
      'categories': _selectedCategories,
      'verifiedOnly': _verifiedSellersOnly,
    };
    widget.onFiltersChanged(_filters);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _dateRange = null;
                    _priceRange = const RangeValues(0, 1000);
                    _locationRadius = 25;
                    _selectedCategories.clear();
                    _verifiedSellersOnly = false;
                  });
                  _updateFilters();
                },
                child: Text('Clear All'),
              ),
            ],
          ),
          SizedBox(height: 2.h),

          // Date Range
          _buildFilterSection(
            'Date Range',
            GestureDetector(
              onTap: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDateRange: _dateRange,
                );
                if (picked != null) {
                  setState(() => _dateRange = picked);
                  _updateFilters();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.outline),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dateRange != null
                          ? '${_dateRange!.start.month}/${_dateRange!.start.day} - ${_dateRange!.end.month}/${_dateRange!.end.day}'
                          : 'Select date range',
                      style: theme.textTheme.bodyMedium,
                    ),
                    CustomIconWidget(
                      iconName: 'calendar_today',
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Price Range
          _buildFilterSection(
            'Price Range (\$${_priceRange.start.round()} - \$${_priceRange.end.round()})',
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              onChanged: (values) {
                setState(() => _priceRange = values);
                _updateFilters();
              },
            ),
          ),

          // Location Radius
          _buildFilterSection(
            'Location Radius (${_locationRadius.round()} miles)',
            Slider(
              value: _locationRadius,
              min: 5,
              max: 100,
              divisions: 19,
              onChanged: (value) {
                setState(() => _locationRadius = value);
                _updateFilters();
              },
            ),
          ),

          // Categories
          _buildFilterSection(
            'Categories',
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: _categories.map((category) {
                final isSelected = _selectedCategories.contains(category);
                return FilterChip(
                  label: Text(category),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                    _updateFilters();
                  },
                  backgroundColor: theme.colorScheme.surface,
                  selectedColor:
                      theme.colorScheme.primary.withValues(alpha: 0.2),
                  checkmarkColor: theme.colorScheme.primary,
                );
              }).toList(),
            ),
          ),

          // Verified Sellers
          _buildFilterSection(
            'Verified Sellers Only',
            Switch(
              value: _verifiedSellersOnly,
              onChanged: (value) {
                setState(() => _verifiedSellersOnly = value);
                _updateFilters();
              },
            ),
          ),

          SizedBox(height: 2.h),

          // Apply Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        content,
        SizedBox(height: 2.h),
      ],
    );
  }
}
