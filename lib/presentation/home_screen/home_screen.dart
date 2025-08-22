import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/category_filter_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/safety_tips_banner_widget.dart';
import './widgets/skeleton_ticket_card_widget.dart';
import './widgets/ticket_card_widget.dart';
import './widgets/ticket_quick_actions_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _showSafetyBanner = true;
  String _selectedCategory = 'All';
  int _notificationCount = 3;
  int _currentBottomNavIndex = 0;
  OverlayEntry? _quickActionsOverlay;

  final List<String> _categories = [
    'All',
    'Concerts',
    'Sports',
    'Theater',
    'Comedy',
    'Festivals'
  ];

  final List<Map<String, dynamic>> _mockTickets = [
    {
      "id": 1,
      "eventName": "Taylor Swift - The Eras Tour",
      "eventDate": "Dec 15, 2024 • 8:00 PM",
      "location": "MetLife Stadium, East Rutherford",
      "price": "\$450",
      "sellerName": "Sarah M.",
      "isSellerVerified": true,
      "eventImage":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop",
      "category": "Concerts",
      "isFeatured": true,
    },
    {
      "id": 2,
      "eventName": "Lakers vs Warriors",
      "eventDate": "Dec 20, 2024 • 7:30 PM",
      "location": "Crypto.com Arena, Los Angeles",
      "price": "\$280",
      "sellerName": "Mike R.",
      "isSellerVerified": true,
      "eventImage":
          "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=800&h=600&fit=crop",
      "category": "Sports",
      "isFeatured": false,
    },
    {
      "id": 3,
      "eventName": "Hamilton Musical",
      "eventDate": "Jan 5, 2025 • 2:00 PM",
      "location": "Richard Rodgers Theatre, NYC",
      "price": "\$320",
      "sellerName": "Jennifer L.",
      "isSellerVerified": false,
      "eventImage":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&h=600&fit=crop",
      "category": "Theater",
      "isFeatured": false,
    },
    {
      "id": 4,
      "eventName": "Dave Chappelle Live",
      "eventDate": "Dec 28, 2024 • 9:00 PM",
      "location": "Madison Square Garden, NYC",
      "price": "\$180",
      "sellerName": "Alex K.",
      "isSellerVerified": true,
      "eventImage":
          "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=800&h=600&fit=crop",
      "category": "Comedy",
      "isFeatured": false,
    },
    {
      "id": 5,
      "eventName": "Coachella 2025 - Weekend 1",
      "eventDate": "Apr 11-13, 2025",
      "location": "Empire Polo Club, Indio",
      "price": "\$650",
      "sellerName": "Emma S.",
      "isSellerVerified": true,
      "eventImage":
          "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=800&h=600&fit=crop",
      "category": "Festivals",
      "isFeatured": true,
    },
    {
      "id": 6,
      "eventName": "Ed Sheeran Mathematics Tour",
      "eventDate": "Jan 18, 2025 • 8:00 PM",
      "location": "Soldier Field, Chicago",
      "price": "\$220",
      "sellerName": "David P.",
      "isSellerVerified": false,
      "eventImage":
          "https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=800&h=600&fit=crop",
      "category": "Concerts",
      "isFeatured": false,
    },
  ];

  List<Map<String, dynamic>> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    _filteredTickets = List.from(_mockTickets);
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _quickActionsOverlay?.remove();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreTickets();
    }
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMoreTickets() async {
    if (_isLoadingMore) return;

    setState(() => _isLoadingMore = true);

    // Simulate loading more tickets
    await Future.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _onRefresh() async {
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mounted) {
      setState(() {
        _filteredTickets = List.from(_mockTickets);
      });
    }
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredTickets = List.from(_mockTickets);
      } else {
        _filteredTickets = _mockTickets
            .where((ticket) => (ticket['category'] as String) == category)
            .toList();
      }
    });
  }

  void _onTicketTap(Map<String, dynamic> ticketData) {
    try {
      // Validate ticket data before navigation
      if (ticketData.isEmpty || ticketData['id'] == null) {
        _showErrorSnackBar('Ticket data is not available');
        return;
      }

      // Create a safe copy of ticket data with fallbacks
      final safeTicketData = Map<String, dynamic>.from(ticketData);

      // Ensure required fields have fallback values
      safeTicketData['eventName'] = safeTicketData['eventName'] ?? 'Event Name';
      safeTicketData['eventDate'] = safeTicketData['eventDate'] ?? 'Date TBD';
      safeTicketData['eventTime'] = safeTicketData['eventTime'] ?? 'Time TBD';
      safeTicketData['location'] = safeTicketData['location'] ?? 'Location TBD';
      safeTicketData['venue'] =
          safeTicketData['venue'] ?? safeTicketData['location'] ?? 'Venue TBD';
      safeTicketData['price'] = safeTicketData['price'] ?? '\$0';
      safeTicketData['sellerName'] =
          safeTicketData['sellerName'] ?? 'Unknown Seller';
      safeTicketData['isSellerVerified'] =
          safeTicketData['isSellerVerified'] ?? false;

      // Navigate to ticket detail with safe data
      Navigator.pushNamed(
        context,
        AppRoutes.ticketDetailScreen,
        arguments: safeTicketData,
      ).catchError((error) {
        // Handle navigation errors
        _showErrorSnackBar('Unable to open ticket details');
        print('Navigation error: $error');
      });
    } catch (e) {
      // Handle any unexpected errors during navigation
      _showErrorSnackBar('Something went wrong while opening ticket');
      print('Ticket tap error: $e');
    }
  }

  void _onTicketLongPress(
      Map<String, dynamic> ticketData, Offset globalPosition) {
    _showQuickActions(globalPosition);
  }

  void _showQuickActions(Offset position) {
    _quickActionsOverlay?.remove();

    _quickActionsOverlay = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx - 75,
        top: position.dy - 100,
        child: Material(
          color: Colors.transparent,
          child: TicketQuickActionsWidget(
            onSave: () {
              _hideQuickActions();
              _showSnackBar('Ticket saved to favorites');
            },
            onShare: () {
              _hideQuickActions();
              _showSnackBar('Sharing ticket...');
            },
            onReport: () {
              _hideQuickActions();
              _showSnackBar('Ticket reported for review');
            },
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_quickActionsOverlay!);

    // Auto-hide after 3 seconds
    Future.delayed(const Duration(seconds: 3), _hideQuickActions);
  }

  void _hideQuickActions() {
    _quickActionsOverlay?.remove();
    _quickActionsOverlay = null;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String time) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderSubtle,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.w),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'notifications',
                color: AppTheme.primaryBlue,
                size: 16,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  time,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() => _currentBottomNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppBar(
        onSearchTap: () => Navigator.pushNamed(context, AppRoutes.search),
        onNotificationTap: () {
          // Show actual notifications with count
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'notifications',
                    color: AppTheme.primaryBlue,
                    size: 24,
                  ),
                  SizedBox(width: 2.w),
                  const Text('Notifications'),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildNotificationItem(
                        'New message from buyer', '2 min ago'),
                    _buildNotificationItem(
                        'Price drop alert: Lakers vs Warriors', '1 hour ago'),
                    _buildNotificationItem(
                        'Your ticket listing was viewed 5 times',
                        '3 hours ago'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Mark all as read
                    setState(() => _notificationCount = 0);
                  },
                  child: const Text('Mark All Read'),
                ),
              ],
            ),
          );
        },
        notificationCount: _notificationCount,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: _isLoading ? _buildLoadingState() : _buildMainContent(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/post-ticket-screen'),
        tooltip: 'Post Ticket',
        child: CustomIconWidget(
          iconName: 'add',
          color: AppTheme.pureWhite,
          size: 24,
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentBottomNavIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      itemCount: 6,
      itemBuilder: (context, index) => const SkeletonTicketCardWidget(),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        CategoryFilterWidget(
          categories: _categories,
          selectedCategory: _selectedCategory,
          onCategorySelected: _onCategorySelected,
        ),
        Expanded(
          child: _filteredTickets.isEmpty
              ? EmptyStateWidget(
                  onResetFilters: () => _onCategorySelected('All'),
                )
              : _buildTicketsList(),
        ),
      ],
    );
  }

  Widget _buildTicketsList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: 1.h),
      itemCount: _filteredTickets.length +
          (_showSafetyBanner ? 1 : 0) +
          (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        // Safety banner appears after first 2 tickets
        if (_showSafetyBanner && index == 2) {
          return SafetyTipsBannerWidget(
            onDismiss: () => setState(() => _showSafetyBanner = false),
          );
        }

        // Adjust index for safety banner
        final ticketIndex = _showSafetyBanner && index > 2 ? index - 1 : index;

        // Loading indicator at the end
        if (ticketIndex >= _filteredTickets.length) {
          return _isLoadingMore
              ? Container(
                  padding: EdgeInsets.all(4.w),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : const SizedBox.shrink();
        }

        final ticketData = _filteredTickets[ticketIndex];

        return GestureDetector(
          onLongPressStart: (details) =>
              _onTicketLongPress(ticketData, details.globalPosition),
          child: TicketCardWidget(
            ticketData: ticketData,
            onTap: () => _onTicketTap(ticketData),
          ),
        );
      },
    );
  }
}
