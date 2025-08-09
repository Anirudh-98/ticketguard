import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SearchSuggestionsWidget extends StatelessWidget {
  final List<String> suggestions;
  final Function(String) onSuggestionTap;

  const SearchSuggestionsWidget({
    super.key,
    required this.suggestions,
    required this.onSuggestionTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: suggestions.length,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            leading: CustomIconWidget(
              iconName: 'search',
              color: theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
            title: Text(
              suggestion,
              style: theme.textTheme.bodyMedium,
            ),
            trailing: CustomIconWidget(
              iconName: 'north_west',
              color: theme.colorScheme.onSurfaceVariant,
              size: 16,
            ),
            onTap: () => onSuggestionTap(suggestion),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 0.5.h,
            ),
          );
        },
      ),
    );
  }
}
