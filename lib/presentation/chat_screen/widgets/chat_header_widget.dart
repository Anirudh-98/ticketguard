import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ChatHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  final String buyerName;
  final String sellerName;
  final bool isVerified;
  final VoidCallback onMorePressed;

  const ChatHeaderWidget({
    super.key,
    required this.buyerName,
    required this.sellerName,
    required this.isVerified,
    required this.onMorePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.pureWhite,
      elevation: 1,
      shadowColor: AppTheme.shadowLight.withValues(alpha: 0.1),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppTheme.textPrimary,
          size: 20,
        ),
      ),
      title: Row(
        children: [
          // User avatar
          Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isVerified
                    ? AppTheme.verificationGreen.withValues(alpha: 0.3)
                    : AppTheme.borderSubtle,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                buyerName.isNotEmpty ? buyerName[0].toUpperCase() : 'U',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),

          SizedBox(width: 3.w),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        buyerName,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isVerified) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: AppTheme.verificationGreen,
                      ),
                    ],
                  ],
                ),
                Text(
                  'Active now',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.verificationGreen,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        // Video call button (optional)
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Video call feature coming soon')),
            );
          },
          icon: const Icon(
            Icons.video_call,
            color: AppTheme.textSecondary,
            size: 24,
          ),
        ),

        // Phone call button (optional)
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Voice call feature coming soon')),
            );
          },
          icon: const Icon(
            Icons.call,
            color: AppTheme.textSecondary,
            size: 20,
          ),
        ),

        // More options button
        IconButton(
          onPressed: onMorePressed,
          icon: const Icon(
            Icons.more_vert,
            color: AppTheme.textSecondary,
            size: 24,
          ),
        ),

        SizedBox(width: 2.w),
      ],
    );
  }
}
