import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdditionalDetailsSectionWidget extends StatefulWidget {
  final String? description;
  final String? venue;
  final String? transferPolicy;

  const AdditionalDetailsSectionWidget({
    super.key,
    this.description,
    this.venue,
    this.transferPolicy,
  });

  @override
  State<AdditionalDetailsSectionWidget> createState() =>
      _AdditionalDetailsSectionWidgetState();
}

class _AdditionalDetailsSectionWidgetState
    extends State<AdditionalDetailsSectionWidget> {
  bool isDescriptionExpanded = false;
  bool isVenueExpanded = false;
  bool isTransferExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        children: [
          // Event Description
          if (widget.description != null)
            _buildExpandableCard(
              title: 'Event Description',
              content: widget.description!,
              isExpanded: isDescriptionExpanded,
              onToggle: () => setState(() {
                isDescriptionExpanded = !isDescriptionExpanded;
              }),
              icon: 'description',
            ),

          SizedBox(height: 1.h),

          // Venue Information
          if (widget.venue != null)
            _buildExpandableCard(
              title: 'Venue Information',
              content: _getVenueInfo(),
              isExpanded: isVenueExpanded,
              onToggle: () => setState(() {
                isVenueExpanded = !isVenueExpanded;
              }),
              icon: 'location_on',
            ),

          SizedBox(height: 1.h),

          // Transfer Policy
          if (widget.transferPolicy != null)
            _buildExpandableCard(
              title: 'Transfer Policy',
              content: widget.transferPolicy!,
              isExpanded: isTransferExpanded,
              onToggle: () => setState(() {
                isTransferExpanded = !isTransferExpanded;
              }),
              icon: 'security',
            ),
        ],
      ),
    );
  }

  Widget _buildExpandableCard({
    required String title,
    required String content,
    required bool isExpanded,
    required VoidCallback onToggle,
    required String icon,
  }) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.h,
            ),
            leading: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
            ),
            title: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: CustomIconWidget(
              iconName: isExpanded ? 'expand_less' : 'expand_more',
              color: theme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            onTap: onToggle,
          ),
          if (isExpanded) ...[
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                content,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getVenueInfo() {
    return '''${widget.venue ?? 'Venue information not available'}

Address: 4 Pennsylvania Plaza, New York, NY 10001
Phone: (212) 465-6741

Parking: Multiple parking garages available nearby
Public Transit: Accessible via subway lines 1, 2, 3, A, C, E at Penn Station
Accessibility: Wheelchair accessible with designated seating areas

Please arrive at least 30 minutes before show time for security screening and to find your seats.''';
  }
}
