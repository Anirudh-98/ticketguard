import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/active_filters_widget.dart';
import './widgets/empty_search_widget.dart';
import './widgets/popular_events_widget.dart';
import './widgets/recent_searches_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/search_filters_widget.dart';
import './widgets/search_results_widget.dart';
import './widgets/search_suggestions_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final AudioRecorder _audioRecorder = AudioRecorder();

  List<String> _recentSearches = [];
  List<String> _searchSuggestions = [];
  List<Map<String, dynamic>> _searchResults = [];
  Map<String, dynamic> _activeFilters = {};
  String _sortBy = 'Relevance';
  bool _isSearching = false;
  bool _isRecording = false;
  bool _showSuggestions = false;

  // Mock data
  final List<Map<String, dynamic>> _popularEvents = [
    {
      "id": 1,
      "name": "Taylor Swift Eras Tour",
      "image":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=300&fit=crop",
      "searchCount": 1250,
    },
    {
      "id": 2,
      "name": "NBA Finals 2024",
      "image":
          "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=400&h=300&fit=crop",
      "searchCount": 890,
    },
    {
      "id": 3,
      "name": "Coachella Music Festival",
      "image":
          "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=400&h=300&fit=crop",
      "searchCount": 756,
    },
    {
      "id": 4,
      "name": "Hamilton Broadway",
      "image":
          "https://images.unsplash.com/photo-1507924538820-ede94a04019d?w=400&h=300&fit=crop",
      "searchCount": 623,
    },
  ];

  final List<Map<String, dynamic>> _mockSearchResults = [
    {
      "id": 1,
      "eventName": "Taylor Swift - The Eras Tour",
      "date": "Dec 15, 2024",
      "venue": "MetLife Stadium",
      "section": "A12",
      "row": "5",
      "quantity": 2,
      "price": "\$450",
      "originalPrice": "\$520",
      "sellerName": "Sarah Johnson",
      "sellerRating": 4.8,
      "sellerReviews": 127,
      "distance": "2.3 miles",
      "isVerified": true,
      "image":
          "https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=300&fit=crop",
    },
    {
      "id": 2,
      "eventName": "Lakers vs Warriors",
      "date": "Dec 20, 2024",
      "venue": "Crypto.com Arena",
      "section": "B15",
      "row": "8",
      "quantity": 4,
      "price": "\$280",
      "originalPrice": null,
      "sellerName": "Mike Chen",
      "sellerRating": 4.5,
      "sellerReviews": 89,
      "distance": "5.7 miles",
      "isVerified": false,
      "image":
          "https://images.unsplash.com/photo-1546519638-68e109498ffc?w=400&h=300&fit=crop",
    },
    {
      "id": 3,
      "eventName": "Hamilton - Broadway Musical",
      "date": "Jan 8, 2025",
      "venue": "Richard Rodgers Theatre",
      "section": "Orchestra",
      "row": "M",
      "quantity": 2,
      "price": "\$320",
      "originalPrice": "\$380",
      "sellerName": "Emily Rodriguez",
      "sellerRating": 4.9,
      "sellerReviews": 203,
      "distance": "12.1 miles",
      "isVerified": true,
      "image":
          "https://images.unsplash.com/photo-1507924538820-ede94a04019d?w=400&h=300&fit=crop",
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  void _loadRecentSearches() {
    setState(() {
      _recentSearches = [
        'Taylor Swift',
        'NBA Finals',
        'Broadway shows',
        'Rock concerts',
      ];
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        _showSuggestions = false;
        _searchSuggestions.clear();
        _searchResults.clear();
        _isSearching = false;
      });
      return;
    }

    // Show suggestions while typing
    if (query.length >= 2) {
      setState(() {
        _showSuggestions = true;
        _searchSuggestions = _generateSuggestions(query);
      });
    }
  }

  List<String> _generateSuggestions(String query) {
    final allSuggestions = [
      'Taylor Swift Eras Tour',
      'Taylor Swift Red Tour',
      'NBA Finals 2024',
      'NBA Lakers',
      'Broadway Hamilton',
      'Broadway Lion King',
      'Rock concerts near me',
      'Rock festivals 2024',
      'Comedy shows',
      'Music festivals',
    ];

    return allSuggestions
        .where((suggestion) =>
            suggestion.toLowerCase().contains(query.toLowerCase()))
        .take(5)
        .toList();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    setState(() {
      _isSearching = true;
      _showSuggestions = false;
      _searchSuggestions.clear();
    });

    // Add to recent searches
    if (!_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 10) {
          _recentSearches = _recentSearches.take(10).toList();
        }
      });
    }

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _searchResults = _mockSearchResults
            .where((result) => (result['eventName'] as String)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        _isSearching = false;
      });
    });

    // Dismiss keyboard
    FocusScope.of(context).unfocus();
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _searchResults.clear();
      _showSuggestions = false;
      _searchSuggestions.clear();
      _isSearching = false;
    });
  }

  void _removeRecentSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  void _onEventTap(String eventName) {
    _searchController.text = eventName;
    _performSearch(eventName);
  }

  void _onSuggestionTap(String suggestion) {
    _searchController.text = suggestion;
    _performSearch(suggestion);
  }

  Future<void> _startVoiceSearch() async {
    if (_isRecording) {
      await _stopVoiceSearch();
      return;
    }

    try {
      // Request microphone permission
      bool hasPermission;
      if (kIsWeb) {
        hasPermission = true; // Browser handles permissions
      } else {
        final status = await Permission.microphone.request();
        hasPermission = status.isGranted;
      }

      if (!hasPermission) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Microphone permission is required for voice search'),
            ),
          );
        }
        return;
      }

      // Start recording
      setState(() => _isRecording = true);

      if (kIsWeb) {
        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.wav),
          path: 'voice_search.wav',
        );
      } else {
        await _audioRecorder.start(
          const RecordConfig(encoder: AudioEncoder.aacLc),
          path: 'voice_search_mobile',
        );
      }

      // Auto-stop after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (_isRecording) {
          _stopVoiceSearch();
        }
      });
    } catch (e) {
      setState(() => _isRecording = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Voice search is not available'),
          ),
        );
      }
    }
  }

  Future<void> _stopVoiceSearch() async {
    if (!_isRecording) return;

    try {
      final path = await _audioRecorder.stop();
      setState(() => _isRecording = false);

      if (path != null) {
        // Simulate voice recognition result
        final mockResults = ['Taylor Swift', 'NBA Finals', 'Broadway shows'];
        final randomResult =
            mockResults[DateTime.now().millisecond % mockResults.length];

        _searchController.text = randomResult;
        _performSearch(randomResult);
      }
    } catch (e) {
      setState(() => _isRecording = false);
    }
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => SearchFiltersWidget(
          activeFilters: _activeFilters,
          onFiltersChanged: (filters) {
            setState(() => _activeFilters = filters);
            _applyFilters();
          },
        ),
      ),
    );
  }

  void _applyFilters() {
    // Apply filters to search results
    // This would typically involve re-querying the backend
    setState(() {
      // Mock filter application
      _searchResults = _mockSearchResults;
    });
  }

  void _removeFilter(String filterKey) {
    setState(() {
      if (filterKey.startsWith('category_')) {
        final category = filterKey.substring(9);
        final categories = _activeFilters['categories'] as List<String>? ?? [];
        categories.remove(category);
        _activeFilters['categories'] = categories;
      } else {
        _activeFilters.remove(filterKey);
      }
    });
    _applyFilters();
  }

  void _onSortChanged(String sortBy) {
    setState(() => _sortBy = sortBy);
    // Apply sorting logic here
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            SearchBarWidget(
              controller: _searchController,
              onChanged: (value) => _onSearchChanged(),
              onVoiceSearch: _startVoiceSearch,
              onClear: _clearSearch,
              showClearButton: _searchController.text.isNotEmpty,
            ),

            // Voice Recording Indicator
            if (_isRecording)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.error.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'mic',
                      color: theme.colorScheme.error,
                      size: 20,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Listening... Tap to stop',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _stopVoiceSearch,
                      child: Container(
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: 'stop',
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Active Filters
            ActiveFiltersWidget(
              activeFilters: _activeFilters,
              onRemoveFilter: _removeFilter,
            ),

            // Filters Button
            if (_searchResults.isNotEmpty)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: _showFilters,
                      icon: CustomIconWidget(
                        iconName: 'tune',
                        color: theme.colorScheme.primary,
                        size: 16,
                      ),
                      label: Text('Filters'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                      ),
                    ),
                  ],
                ),
              ),

            // Content
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home-screen');
              break;
            case 1:
              // Already on search screen
              break;
            case 2:
              Navigator.pushNamed(context, '/post-ticket-screen');
              break;
          }
        },
      ),
    );
  }

  Widget _buildContent() {
    // Show suggestions while typing
    if (_showSuggestions && _searchSuggestions.isNotEmpty) {
      return SingleChildScrollView(
        child: SearchSuggestionsWidget(
          suggestions: _searchSuggestions,
          onSuggestionTap: _onSuggestionTap,
        ),
      );
    }

    // Show loading
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Show search results
    if (_searchResults.isNotEmpty) {
      return SearchResultsWidget(
        searchResults: _searchResults,
        sortBy: _sortBy,
        onSortChanged: _onSortChanged,
      );
    }

    // Show empty search state
    if (_searchController.text.isNotEmpty) {
      return EmptySearchWidget(
        searchQuery: _searchController.text,
        onSuggestionTap: _onSuggestionTap,
      );
    }

    // Show default content (recent searches + popular events)
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 2.h),

          // Recent Searches
          RecentSearchesWidget(
            recentSearches: _recentSearches,
            onSearchTap: _onSuggestionTap,
            onRemoveSearch: _removeRecentSearch,
          ),

          SizedBox(height: 3.h),

          // Popular Events
          PopularEventsWidget(
            popularEvents: _popularEvents,
            onEventTap: _onEventTap,
          ),

          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}