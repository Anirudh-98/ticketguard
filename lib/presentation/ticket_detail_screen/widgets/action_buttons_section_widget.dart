import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActionButtonsSectionWidget extends StatelessWidget {
  final VoidCallback? onContactSeller;
  final VoidCallback? onSaveTicket;
  final VoidCallback? onReportListing;
  final bool isSaved;

  const ActionButtonsSectionWidget({
    super.key,
    this.onContactSeller,
    this.onSaveTicket,
    this.onReportListing,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          // Primary action - Contact Seller
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onContactSeller,
              icon: CustomIconWidget(
                iconName: 'chat',
                color: Colors.white,
                size: 20,
              ),
              label: Text(
                'Contact Seller',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 3.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),

          // Secondary actions row
          Row(
            children: [
              // Save ticket button
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onSaveTicket,
                  icon: CustomIconWidget(
                    iconName: isSaved ? 'bookmark' : 'bookmark_border',
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                  label: Text(
                    isSaved ? 'Saved' : 'Save Ticket',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryBlue,
                    padding: EdgeInsets.symmetric(vertical: 2.5.h),
                    side: BorderSide(
                      color: AppTheme.primaryBlue,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.w),

              // Report listing button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onReportListing,
                  icon: CustomIconWidget(
                    iconName: 'flag',
                    color: AppTheme.textPrimary,
                    size: 20,
                  ),
                  label: Text(
                    'Report Listing',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.warningYellow,
                    foregroundColor: AppTheme.textPrimary,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(vertical: 2.5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
