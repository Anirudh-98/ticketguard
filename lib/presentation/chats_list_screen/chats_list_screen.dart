import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/conversation_actions_widget.dart';
import './widgets/conversation_card_widget.dart';
import './widgets/empty_chats_widget.dart';
import './widgets/search_bar_widget.dart';

class ChatsListScreen extends StatefulWidget {
  const ChatsListScreen({super.key});

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String _searchQuery = '';
  bool _isSearchActive = false;
  bool _isMultiSelectMode = false;
  final Set<String> _selectedConversations = <String>{};
  late AnimationController _searchAnimationController;
  late Animation<double> _searchAnimation;

  // Mock conversation data - replace with actual data source
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'contactName': 'John Smith',
      'isVerified': true,
      'profileImage':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      'lastMessage':
          'Is the ticket still available? I\'m very interested in purchasing.',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'unreadCount': 2,
      'isOnline': true,
      'isArchived': false,
      'ticketTitle': 'Taylor Swift Concert - Section A',
    },
    {
      'id': '2',
      'contactName': 'Sarah Johnson',
      'isVerified': false,
      'profileImage':
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Thanks for the quick response! Can we meet tomorrow?',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'unreadCount': 0,
      'isOnline': false,
      'isArchived': false,
      'ticketTitle': 'NBA Finals Game 7',
    },
    {
      'id': '3',
      'contactName': 'Michael Chen',
      'isVerified': true,
      'profileImage':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Perfect! I\'ll transfer the payment now.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 4)),
      'unreadCount': 0,
      'isOnline': true,
      'isArchived': false,
      'ticketTitle': 'Broadway Show - Hamilton',
    },
    {
      'id': '4',
      'contactName': 'Emma Wilson',
      'isVerified': true,
      'profileImage':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Could you send more photos of the tickets?',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'unreadCount': 1,
      'isOnline': false,
      'isArchived': false,
      'ticketTitle': 'Music Festival Weekend Pass',
    },
    {
      'id': '5',
      'contactName': 'David Brown',
      'isVerified': false,
      'profileImage':
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150&h=150&fit=crop&crop=face',
      'lastMessage': 'Meeting confirmed for 3 PM at the venue entrance.',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'unreadCount': 0,
      'isOnline': false,
      'isArchived': true,
      'ticketTitle': 'Football Championship',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchAnimation = CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchAnimationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredConversations {
    List<Map<String, dynamic>> filtered =
        _conversations.where((conv) => !conv['isArchived']).toList();

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((conv) {
        return conv['contactName']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            conv['lastMessage']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            conv['ticketTitle']
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Sort by timestamp, unread first
    filtered.sort((a, b) {
      if (a['unreadCount'] > 0 && b['unreadCount'] == 0) return -1;
      if (a['unreadCount'] == 0 && b['unreadCount'] > 0) return 1;
      return b['timestamp'].compareTo(a['timestamp']);
    });

    return filtered;
  }

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
      if (!_isSearchActive) {
        _searchQuery = '';
        _searchController.clear();
        _searchAnimationController.reverse();
      } else {
        _searchAnimationController.forward();
      }
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _refreshConversations() async {
    // Simulate network call
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        // Refresh logic here
      });
    }
  }

  void _toggleMultiSelect() {
    setState(() {
      _isMultiSelectMode = !_isMultiSelectMode;
      if (!_isMultiSelectMode) {
        _selectedConversations.clear();
      }
    });
  }

  void _toggleConversationSelection(String conversationId) {
    setState(() {
      if (_selectedConversations.contains(conversationId)) {
        _selectedConversations.remove(conversationId);
      } else {
        _selectedConversations.add(conversationId);
      }

      if (_selectedConversations.isEmpty) {
        _isMultiSelectMode = false;
      }
    });
  }

  void _archiveSelected() {
    setState(() {
      for (String id in _selectedConversations) {
        final conv = _conversations.firstWhere((c) => c['id'] == id);
        conv['isArchived'] = true;
      }
      _selectedConversations.clear();
      _isMultiSelectMode = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('${_selectedConversations.length} conversation(s) archived'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // Implement undo functionality
          },
        ),
      ),
    );
  }

  void _deleteSelected() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Conversations'),
        content: Text(
          'Are you sure you want to delete ${_selectedConversations.length} conversation(s)? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _conversations.removeWhere(
                  (conv) => _selectedConversations.contains(conv['id']),
                );
                _selectedConversations.clear();
                _isMultiSelectMode = false;
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _navigateToChat(Map<String, dynamic> conversation) {
    if (_isMultiSelectMode) {
      _toggleConversationSelection(conversation['id']);
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.chatScreen,
      arguments: {
        'conversationId': conversation['id'],
        'contactName': conversation['contactName'],
        'isVerified': conversation['isVerified'],
        'profileImage': conversation['profileImage'],
        'ticketTitle': conversation['ticketTitle'],
      },
    );
  }

  void _showConversationActions(Map<String, dynamic> conversation) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ConversationActionsWidget(
        conversation: conversation,
        onArchive: () {
          setState(() {
            conversation['isArchived'] = true;
          });
          Navigator.pop(context);
        },
        onDelete: () {
          setState(() {
            _conversations.remove(conversation);
          });
          Navigator.pop(context);
        },
        onBlock: () {
          // Implement block functionality
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User blocked successfully')),
          );
        },
        onReport: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Report sent to support team')),
          );
        },
      ),
    );
  }

  void _navigateToArchivedChats() {
    // Navigate to archived chats screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Archived chats feature coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredConversations = _filteredConversations;

    return Scaffold(
      appBar: AppBar(
        title: _isMultiSelectMode
            ? Text('${_selectedConversations.length} selected')
            : const Text('Messages'),
        leading: _isMultiSelectMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _toggleMultiSelect,
              )
            : null,
        actions: [
          if (_isMultiSelectMode) ...[
            IconButton(
              icon: const Icon(Icons.archive_outlined),
              onPressed:
                  _selectedConversations.isNotEmpty ? _archiveSelected : null,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed:
                  _selectedConversations.isNotEmpty ? _deleteSelected : null,
            ),
          ] else ...[
            IconButton(
              icon: Icon(_isSearchActive ? Icons.close : Icons.search),
              onPressed: _toggleSearch,
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'archived':
                    _navigateToArchivedChats();
                    break;
                  case 'select':
                    _toggleMultiSelect();
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'archived',
                  child: Row(
                    children: [
                      Icon(Icons.archive_outlined),
                      SizedBox(width: 12),
                      Text('Archived'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'select',
                  child: Row(
                    children: [
                      Icon(Icons.checklist),
                      SizedBox(width: 12),
                      Text('Select'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Search bar with animation
          AnimatedBuilder(
            animation: _searchAnimation,
            builder: (context, child) {
              return SizeTransition(
                sizeFactor: _searchAnimation,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: SearchBarWidget(
                    controller: _searchController,
                    hintText: 'Search conversations...',
                    onChanged: _onSearchChanged,
                  ),
                ),
              );
            },
          ),

          // Conversations list
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refreshConversations,
              child: filteredConversations.isEmpty
                  ? EmptyChatsWidget(
                      searchQuery: _searchQuery,
                      onStartConversation: () {
                        Navigator.pushNamed(context, AppRoutes.search);
                      },
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredConversations.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      ),
                      itemBuilder: (context, index) {
                        final conversation = filteredConversations[index];
                        final isSelected =
                            _selectedConversations.contains(conversation['id']);

                        return ConversationCardWidget(
                          conversation: conversation,
                          isSelected: isSelected,
                          isMultiSelectMode: _isMultiSelectMode,
                          onTap: () => _navigateToChat(conversation),
                          onLongPress: () => _isMultiSelectMode
                              ? null
                              : _toggleConversationSelection(
                                  conversation['id']),
                          onActionsTap: () =>
                              _showConversationActions(conversation),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 3, // Messages tab index
        onTap: _onBottomNavTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.search);
        },
        child: const Icon(Icons.message_outlined),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.search);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.postTicket);
        break;
    }
  }
}