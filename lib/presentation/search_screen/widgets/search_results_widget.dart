import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults;
  final String sortBy;
  final Function(String) onSortChanged;

  const SearchResultsWidget({
    super.key,
    required this.searchResults,
    required this.sortBy,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Sort Options Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${searchResults.length} results found',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              GestureDetector(
                onTap: () => _showSortOptions(context),
                child: Row(
                  children: [
                    Text(
                      'Sort: $sortBy',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    CustomIconWidget(
                      iconName: 'sort',
                      color: theme.colorScheme.primary,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Results List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final ticket = searchResults[index];
              return _buildTicketCard(context, ticket);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTicketCard(BuildContext context, Map<String, dynamic> ticket) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CustomImageWidget(
              imageUrl: ticket['image'] as String,
              width: double.infinity,
              height: 20.h,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Name and Verification
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ticket['eventName'] as String,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (ticket['isVerified'] == true)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color:
                              AppTheme.verificationGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'verified',
                              color: AppTheme.verificationGreen,
                              size: 12,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Verified',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppTheme.verificationGreen,
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 1.h),

                // Date and Venue
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'calendar_today',
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      ticket['date'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    CustomIconWidget(
                      iconName: 'location_on',
                      color: theme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        ticket['venue'] as String,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 1.h),

                // Section and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Section ${ticket['section']} • Row ${ticket['row']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${ticket['quantity']} ticket${(ticket['quantity'] as int) > 1 ? 's' : ''}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ticket['price'] as String,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (ticket['originalPrice'] != null)
                          Text(
                            ticket['originalPrice'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 1.5.h),

                // Seller Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 2.5.w,
                      backgroundColor:
                          theme.colorScheme.primary.withValues(alpha: 0.1),
                      child: Text(
                        (ticket['sellerName'] as String)[0].toUpperCase(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ticket['sellerName'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return CustomIconWidget(
                                  iconName: index <
                                          (ticket['sellerRating'] as double)
                                              .floor()
                                      ? 'star'
                                      : 'star_border',
                                  color: AppTheme.warningYellow,
                                  size: 12,
                                );
                              }),
                              SizedBox(width: 1.w),
                              Text(
                                '${ticket['sellerRating']} (${ticket['sellerReviews']} reviews)',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      ticket['distance'] as String,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    final theme = Theme.of(context);
    final sortOptions = [
      'Relevance',
      'Price: Low to High',
      'Price: High to Low',
      'Date',
      'Distance'
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort by',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            ...sortOptions.map((option) => ListTile(
                  title: Text(option),
                  trailing: sortBy == option
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: theme.colorScheme.primary,
                          size: 20,
                        )
                      : null,
                  onTap: () {
                    onSortChanged(option);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
