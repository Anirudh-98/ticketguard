import 'package:flutter/material.dart';

class ConversationActionsWidget extends StatelessWidget {
  final Map<String, dynamic> conversation;
  final VoidCallback onArchive;
  final VoidCallback onDelete;
  final VoidCallback onBlock;
  final VoidCallback onReport;

  const ConversationActionsWidget({
    super.key,
    required this.conversation,
    required this.onArchive,
    required this.onDelete,
    required this.onBlock,
    required this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 16),

          // Conversation info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            conversation['contactName'] ?? '',
                            style: theme.textTheme.titleMedium,
                          ),
                          if (conversation['isVerified'] == true) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.verified,
                              size: 16,
                              color: theme.colorScheme.secondary,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        conversation['ticketTitle'] ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Action buttons
          _buildActionTile(
            context,
            icon: Icons.archive_outlined,
            title: 'Archive',
            onTap: onArchive,
          ),
          _buildActionTile(
            context,
            icon: Icons.block_outlined,
            title: 'Block User',
            onTap: onBlock,
            isDestructive: true,
          ),
          _buildActionTile(
            context,
            icon: Icons.report_outlined,
            title: 'Report',
            onTap: onReport,
            isDestructive: true,
          ),
          _buildActionTile(
            context,
            icon: Icons.delete_outline,
            title: 'Delete Conversation',
            onTap: onDelete,
            isDestructive: true,
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final color =
        isDestructive ? theme.colorScheme.error : theme.colorScheme.onSurface;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: color,
        ),
      ),
      onTap: onTap,
      visualDensity: VisualDensity.compact,
    );
  }
}
