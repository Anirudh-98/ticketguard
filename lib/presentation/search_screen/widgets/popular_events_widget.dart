import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PopularEventsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> popularEvents;
  final Function(String) onEventTap;

  const PopularEventsWidget({
    super.key,
    required this.popularEvents,
    required this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            children: [
              CustomIconWidget(
                iconName: 'trending_up',
                color: theme.colorScheme.primary,
                size: 20,
              ),
              SizedBox(width: 2.w),
              Text(
                'Popular Events',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: popularEvents.length,
            itemBuilder: (context, index) {
              final event = popularEvents[index];
              return GestureDetector(
                onTap: () => onEventTap(event['name'] as String),
                child: Container(
                  width: 40.w,
                  margin: EdgeInsets.only(right: 3.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        CustomImageWidget(
                          imageUrl: event['image'] as String,
                          width: 40.w,
                          height: 20.h,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2.h,
                          left: 3.w,
                          right: 3.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event['name'] as String,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Row(
                                children: [
                                  CustomIconWidget(
                                    iconName: 'search',
                                    color: Colors.white.withValues(alpha: 0.8),
                                    size: 12,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    '${event['searchCount']} searches',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color:
                                          Colors.white.withValues(alpha: 0.8),
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
