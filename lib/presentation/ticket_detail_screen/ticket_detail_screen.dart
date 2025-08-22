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
    try {
      // Get arguments passed from navigation with better error handling
      final args = ModalRoute.of(context)?.settings.arguments;

      Map<String, dynamic> receivedData = {};

      // Handle different argument types safely
      if (args is Map<String, dynamic>) {
        receivedData = Map<String, dynamic>.from(args);
      } else if (args is Map) {
        // Convert Map to Map<String, dynamic>
        receivedData = args.cast<String, dynamic>();
      }

      // Enhanced mock ticket data with fallbacks for all required fields
      setState(() {
        ticketData = {
          // Use received data or fallback to mock data
          'eventId': receivedData['id']?.toString() ?? 'evt_001',
          'eventName':
              receivedData['eventName'] ?? 'Taylor Swift | The Eras Tour',
          'eventImage': receivedData['eventImage'] ??
              'https://images.unsplash.com/photo-1540039155733-5bb30b53aa14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2274&q=80',
          'eventDate': receivedData['eventDate'] ?? 'Saturday, March 15, 2025',
          'eventTime': receivedData['eventTime'] ?? '7:30 PM',
          'location': receivedData['location'] ?? 'Madison Square Garden',
          'venue': receivedData['venue'] ??
              receivedData['location'] ??
              'Madison Square Garden, New York, NY',
          'section': receivedData['section'] ?? 'Section 102',
          'row': receivedData['row'] ?? 'Row 12',
          'seat': receivedData['seat'] ?? 'Seats 5-6',
          'quantity': receivedData['quantity'] ?? 2,
          'originalPrice': receivedData['originalPrice'] ?? '\$450.00',
          'currentPrice': receivedData['price'] ??
              receivedData['currentPrice'] ??
              '\$380.00',
          'isDiscounted': receivedData['isDiscounted'] ?? true,
          'sellerId': receivedData['sellerId'] ?? 'usr_001',
          'sellerName': receivedData['sellerName'] ?? 'Sarah Johnson',
          'sellerImage': receivedData['sellerImage'] ??
              'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
          'isVerified': receivedData['isSellerVerified'] ??
              receivedData['isVerified'] ??
              true,
          'rating': receivedData['rating']?.toDouble() ?? 4.8,
          'memberSince': receivedData['memberSince'] ?? 'March 2020',
          'responseTime':
              receivedData['responseTime'] ?? 'Usually responds within 1 hour',
          'successfulSales': receivedData['successfulSales'] ?? 47,
          'description': receivedData['description'] ??
              'Amazing seats with great view of the stage! I can\'t make it to the show anymore due to a work conflict. These are legitimate tickets purchased through official channels. Will provide proof of purchase.',
          'transferPolicy': receivedData['transferPolicy'] ??
              'Mobile tickets will be transferred through official platform. Seller guarantees authenticity.',
          'isFeatured': receivedData['isFeatured'] ?? false,
        };
        isLoading = false;
      });
    } catch (e) {
      // Handle any errors during data loading
      print('Error loading ticket data: $e');
      setState(() {
        // Provide complete fallback data
        ticketData = {
          'eventId': 'evt_fallback',
          'eventName': 'Event Details',
          'eventImage':
              'https://images.unsplash.com/photo-1540039155733-5bb30b53aa14?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2274&q=80',
          'eventDate': 'Date TBD',
          'eventTime': 'Time TBD',
          'location': 'Venue TBD',
          'venue': 'Venue TBD',
          'section': 'Section TBD',
          'row': 'Row TBD',
          'seat': 'Seat TBD',
          'quantity': 1,
          'originalPrice': '\$0.00',
          'currentPrice': '\$0.00',
          'isDiscounted': false,
          'sellerId': 'unknown',
          'sellerName': 'Unknown Seller',
          'sellerImage':
              'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
          'isVerified': false,
          'rating': 0.0,
          'memberSince': 'Unknown',
          'responseTime': 'Response time unknown',
          'successfulSales': 0,
          'description': 'No description available.',
          'transferPolicy': 'Transfer policy not available.',
          'isFeatured': false,
        };
        isLoading = false;
      });

      // Show error message to user
      Future.delayed(Duration.zero, () {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Some ticket details may be unavailable'),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      });
    }
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
