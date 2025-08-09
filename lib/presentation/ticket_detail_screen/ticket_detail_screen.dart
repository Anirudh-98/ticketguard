import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/action_buttons_section_widget.dart';
import './widgets/additional_details_section_widget.dart';
import './widgets/event_hero_section_widget.dart';
import './widgets/event_info_section_widget.dart';
import './widgets/seller_info_section_widget.dart';
import './widgets/ticket_info_section_widget.dart';

class TicketDetailScreen extends StatefulWidget {
  const TicketDetailScreen({super.key});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  Map<String, dynamic> ticketData = {};
  bool isLoading = true;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTicketData();
    });
  }

  void _loadTicketData() {
    // Get arguments passed from navigation
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Mock ticket data - in real app this would come from API/database
    setState(() {
      ticketData = args ??
          {
            'eventId': 'evt_001',
            'eventName': 'Taylor Swift | The Eras Tour',
            'eventImage':
                'https://images.unsplash.com/photo-1540039155733-5bb30b53aa14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2274&q=80',
            'eventDate': 'Saturday, March 15, 2025',
            'eventTime': '7:30 PM',
            'location': 'Madison Square Garden',
            'venue': 'Madison Square Garden, New York, NY',
            'section': 'Section 102',
            'row': 'Row 12',
            'seat': 'Seats 5-6',
            'quantity': 2,
            'originalPrice': '\$450.00',
            'currentPrice': '\$380.00',
            'isDiscounted': true,
            'sellerId': 'usr_001',
            'sellerName': 'Sarah Johnson',
            'sellerImage':
                'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
            'isVerified': true,
            'rating': 4.8,
            'memberSince': 'March 2020',
            'responseTime': 'Usually responds within 1 hour',
            'successfulSales': 47,
            'description':
                'Amazing seats with great view of the stage! I can\'t make it to the show anymore due to a work conflict. These are legitimate tickets purchased through official channels. Will provide proof of purchase.',
            'transferPolicy':
                'Mobile tickets will be transferred through official platform. Seller guarantees authenticity.',
            'isFeatured': false,
          };
      isLoading = false;
    });
  }

  void _handleBackPressed() {
    Navigator.pop(context);
  }

  void _handleSharePressed() {
    HapticFeedback.lightImpact();
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share functionality not implemented yet'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleContactSeller() {
    HapticFeedback.mediumImpact();
    // Navigate to messaging interface
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Opening conversation with ${ticketData['sellerName']}...'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleSaveTicket() {
    HapticFeedback.lightImpact();
    setState(() {
      isSaved = !isSaved;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSaved ? 'Ticket saved!' : 'Ticket removed from saved'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleReportListing() {
    HapticFeedback.heavyImpact();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _buildReportModal(),
    );
  }

  Widget _buildReportModal() {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.warningYellow,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Report this listing',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          _buildReportOption(
              'Suspicious pricing', 'Price seems too good to be true'),
          _buildReportOption(
              'Fake tickets', 'I suspect these tickets are not legitimate'),
          _buildReportOption('Inappropriate content',
              'Description contains inappropriate material'),
          _buildReportOption(
              'Duplicate listing', 'I\'ve seen this exact listing elsewhere'),
          _buildReportOption(
              'Other', 'Something else is wrong with this listing'),
          SizedBox(height: 2.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ),
          SizedBox(height: 1.h),
        ],
      ),
    );
  }

  Widget _buildReportOption(String title, String subtitle) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.5.h),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall,
      ),
      trailing: CustomIconWidget(
        iconName: 'chevron_right',
        color: theme.colorScheme.onSurfaceVariant,
        size: 20,
      ),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Report submitted for review'),
            backgroundColor: AppTheme.warningYellow,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          EventHeroSectionWidget(
            eventImage: ticketData['eventImage'],
            onBackPressed: _handleBackPressed,
            onSharePressed: _handleSharePressed,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                EventInfoSectionWidget(
                  eventName: ticketData['eventName'],
                  eventDate: ticketData['eventDate'],
                  eventTime: ticketData['eventTime'],
                  venue: ticketData['venue'],
                ),
                TicketInfoSectionWidget(
                  section: ticketData['section'],
                  row: ticketData['row'],
                  seat: ticketData['seat'],
                  quantity: ticketData['quantity'],
                  currentPrice: ticketData['currentPrice'],
                  originalPrice: ticketData['originalPrice'],
                  isDiscounted: ticketData['isDiscounted'],
                ),
                SellerInfoSectionWidget(
                  sellerName: ticketData['sellerName'],
                  sellerImage: ticketData['sellerImage'],
                  isVerified: ticketData['isVerified'],
                  rating: ticketData['rating'],
                  memberSince: ticketData['memberSince'],
                  responseTime: ticketData['responseTime'],
                  successfulSales: ticketData['successfulSales'],
                ),
                ActionButtonsSectionWidget(
                  onContactSeller: _handleContactSeller,
                  onSaveTicket: _handleSaveTicket,
                  onReportListing: _handleReportListing,
                  isSaved: isSaved,
                ),
                AdditionalDetailsSectionWidget(
                  description: ticketData['description'],
                  venue: ticketData['venue'],
                  transferPolicy: ticketData['transferPolicy'],
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
