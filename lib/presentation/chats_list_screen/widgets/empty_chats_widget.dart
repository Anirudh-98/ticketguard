import 'package:flutter/material.dart';

class EmptyChatsWidget extends StatelessWidget {
  final String searchQuery;
  final VoidCallback onStartConversation;

  const EmptyChatsWidget({
    super.key,
    required this.searchQuery,
    required this.onStartConversation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSearchResult = searchQuery.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearchResult ? Icons.search_off : Icons.chat_bubble_outline,
                size: 72,
                color: theme.colorScheme.primary.withValues(alpha: 0.6),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              isSearchResult ? 'No conversations found' : 'No messages yet',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              isSearchResult
                  ? 'Try searching with different keywords or check your spelling.'
                  : 'Start connecting with ticket sellers and buyers. Your conversations will appear here.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            if (!isSearchResult) ...[
              const SizedBox(height: 32),

              // Action button
              ElevatedButton.icon(
                onPressed: onStartConversation,
                icon: const Icon(Icons.search),
                label: const Text('Find Tickets'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Safety tip
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: theme.colorScheme.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Always meet in public places and verify tickets before payment.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
