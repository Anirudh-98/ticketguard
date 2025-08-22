import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/chat_header_widget.dart';
import './widgets/chat_input_widget.dart';
import './widgets/message_bubble_widget.dart';
import './widgets/safety_tips_banner_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();

  bool _showSafetyBanner = true;
  bool _isTyping = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadChatData();
    _addInitialMessages();
  }

  void _loadChatData() {
    // Simulate loading chat data
    // In real implementation, load from arguments or API
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    setState(() {
      // Mock data for demonstration
      _messages = [
        ChatMessage(
          id: '1',
          senderId: 'seller123',
          senderName: 'Sarah Johnson',
          message:
              'Hi! The tickets are still available. They\'re great seats in section A!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          isMe: false,
          isRead: true,
        ),
        ChatMessage(
          id: '2',
          senderId: 'buyer456',
          senderName: 'You',
          message:
              'That sounds perfect! Can you send me more details about the seat numbers?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
          isMe: true,
          isRead: true,
        ),
      ];
    });
  }

  void _addInitialMessages() {
    // Add initial safety message if this is first conversation
    if (_messages.isEmpty || _showSafetyBanner) {
      // Show safety banner for first-time users
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'buyer456',
      senderName: 'You',
      message: _messageController.text.trim(),
      timestamp: DateTime.now(),
      isMe: true,
      isRead: false,
    );

    setState(() {
      _messages.add(message);
      _messageController.clear();
    });

    _scrollToBottom();

    // Simulate typing indicator and response
    _simulateTypingResponse();
  }

  void _simulateTypingResponse() {
    setState(() {
      _isTyping = true;
    });

    // Simulate response after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(
            ChatMessage(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              senderId: 'seller123',
              senderName: 'Sarah Johnson',
              message:
                  'Sure! The seats are A15 and A16, row 12. Perfect view of the stage!',
              timestamp: DateTime.now(),
              isMe: false,
              isRead: false,
            ),
          );
        });
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _dismissSafetyBanner() {
    setState(() {
      _showSafetyBanner = false;
    });
  }

  void _showOptionsMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report, color: AppTheme.errorRed),
              title: const Text('Report User'),
              onTap: () {
                Navigator.pop(context);
                _showReportDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppTheme.errorRed),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                _showBlockDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support,
                  color: AppTheme.primaryBlue),
              title: const Text('Contact Support'),
              onTap: () {
                Navigator.pop(context);
                // Implement support contact
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report User'),
        content: const Text(
            'Are you sure you want to report this user? This will notify our support team.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User reported successfully')),
              );
            },
            child: const Text('Report'),
          ),
        ],
      ),
    );
  }

  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text(
            'Are you sure you want to block this user? You won\'t receive any more messages from them.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to previous screen
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.errorRed),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: ChatHeaderWidget(
        buyerName: 'Sarah Johnson',
        sellerName: 'You',
        isVerified: true,
        onMorePressed: _showOptionsMenu,
      ),
      body: Column(
        children: [
          // Safety tips banner
          if (_showSafetyBanner)
            SafetyTipsBannerWidget(
              onDismiss: _dismissSafetyBanner,
            ),

          // Messages list
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length && _isTyping) {
                    // Typing indicator
                    return Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppTheme.neutralGray,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: const AlwaysStoppedAnimation(
                                    AppTheme.textSecondary),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'typing...',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppTheme.textSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final message = _messages[index];
                  return MessageBubbleWidget(
                    message: message,
                    showSenderName: !message.isMe,
                  );
                },
              ),
            ),
          ),

          // Chat input
          ChatInputWidget(
            controller: _messageController,
            focusNode: _messageFocusNode,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }
}

// Chat message model
class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime timestamp;
  final bool isMe;
  final bool isRead;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.isMe,
    required this.isRead,
  });
}
