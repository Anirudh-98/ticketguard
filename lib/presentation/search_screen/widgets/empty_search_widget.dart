import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class EmptySearchWidget extends StatelessWidget {
  final String searchQuery;
  final Function(String) onSuggestionTap;

  const EmptySearchWidget({
    super.key,
    required this.searchQuery,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final suggestions = _getSearchSuggestions();

    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: CustomIconWidget(
                iconName: 'search_off',
                color: theme.colorScheme.primary,
                size: 15.w,
              ),
            ),

            SizedBox(height: 3.h),

            // Title
            Text(
              searchQuery.isEmpty ? 'Start your search' : 'No results found',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 1.h),

            // Description
            Text(
              searchQuery.isEmpty
                  ? 'Search for events, artists, venues, or browse popular events below'
                  : 'We couldn\'t find any tickets matching "$searchQuery". Try adjusting your search or filters.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            if (searchQuery.isNotEmpty) ...[
              SizedBox(height: 3.h),

              // Suggestions
              Text(
                'Try searching for:',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 2.h),

              Wrap(
                spacing: 2.w,
                runSpacing: 1.h,
                alignment: WrapAlignment.center,
                children: suggestions.map((suggestion) {
                  return GestureDetector(
                    onTap: () => onSuggestionTap(suggestion),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              theme.colorScheme.primary.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        suggestion,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<String> _getSearchSuggestions() {
    return [
      'Taylor Swift',
      'NBA Finals',
      'Broadway Shows',
      'Rock Concerts',
      'Comedy Shows',
      'Music Festivals',
    ];
  }
}
