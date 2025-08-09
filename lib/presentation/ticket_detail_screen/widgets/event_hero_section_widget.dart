import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EventHeroSectionWidget extends StatelessWidget {
  final String? eventImage;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSharePressed;

  const EventHeroSectionWidget({
    super.key,
    this.eventImage,
    this.onBackPressed,
    this.onSharePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      expandedHeight: 35.h,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Colors.white,
            size: 24,
          ),
          onPressed: onBackPressed,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: CustomIconWidget(
              iconName: 'share',
              color: Colors.white,
              size: 24,
            ),
            onPressed: onSharePressed,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Event image
            CustomImageWidget(
              imageUrl: eventImage ?? '',
              fit: BoxFit.cover,
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.3),
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
