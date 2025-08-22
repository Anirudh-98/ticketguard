import 'package:flutter/material.dart';

class SettingsSectionWidget extends StatelessWidget {
  const SettingsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Settings',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Verification Section (prominent)
          _buildVerificationCard(context),

          const SizedBox(height: 24),

          // Settings Options
          Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _buildSettingItem(
                  context: context,
                  icon: Icons.payment_outlined,
                  title: 'Payment Methods',
                  subtitle: 'Manage cards and payment options',
                  onTap: () {
                    // TODO: Navigate to payment methods
                  },
                ),
                _buildDivider(context),
                _buildSettingItem(
                  context: context,
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Push notifications and email preferences',
                  onTap: () {
                    // TODO: Navigate to notification settings
                  },
                ),
                _buildDivider(context),
                _buildSettingItem(
                  context: context,
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Settings',
                  subtitle: 'Control your privacy and data settings',
                  onTap: () {
                    // TODO: Navigate to privacy settings
                  },
                ),
                _buildDivider(context),
                _buildSettingItem(
                  context: context,
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  subtitle: 'FAQs, support, and contact information',
                  onTap: () {
                    // TODO: Navigate to help center
                  },
                  showTrailing: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationCard(BuildContext context) {
    final theme = Theme.of(context);
    final isVerified = true; // This would come from user data

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isVerified ? Icons.verified : Icons.verified_outlined,
                  color: theme.colorScheme.onPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isVerified ? 'Account Verified' : 'Get Verified',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isVerified
                          ? 'Your account is fully verified'
                          : 'Complete verification to build trust',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isVerified) ...[
            const SizedBox(height: 16),

            // Progress Indicators for Incomplete Verification
            Column(
              children: [
                _buildVerificationStep(
                  context: context,
                  title: 'Email Verification',
                  isCompleted: true,
                ),
                const SizedBox(height: 8),
                _buildVerificationStep(
                  context: context,
                  title: 'Phone Number',
                  isCompleted: false,
                ),
                const SizedBox(height: 8),
                _buildVerificationStep(
                  context: context,
                  title: 'Identity Document',
                  isCompleted: false,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Get Verified CTA Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to verification process
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
                child: Text('Get Verified'),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerificationStep({
    required BuildContext context,
    required String title,
    required bool isCompleted,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted
              ? theme.colorScheme.secondary
              : theme.colorScheme.onSurfaceVariant,
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isCompleted
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.onSurfaceVariant,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showTrailing = true,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (showTrailing)
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 56),
      child: Divider(
        height: 1,
        thickness: 1,
        color: theme.colorScheme.outline.withValues(alpha: 0.1),
      ),
    );
  }
}
