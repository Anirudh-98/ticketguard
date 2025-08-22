import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_image_widget.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  bool _isVerified = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: theme.cardColor,
            border: Border(
                bottom: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    width: 1))),
        child: Column(children: [
          // Avatar with Camera Icon
          Stack(children: [
            Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.2),
                        width: 2)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomImageWidget(
                        imageUrl: '',
                        height: 100, width: 100, fit: BoxFit.cover))),
            Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                    onTap: _showPhotoUpdateOptions,
                    child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: theme.scaffoldBackgroundColor,
                                width: 2)),
                        child: Icon(Icons.camera_alt,
                            color: theme.colorScheme.onPrimary, size: 16)))),
          ]),

          const SizedBox(height: 16),

          // Username with Verification Badge
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('john.doe2024',
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w600)),
            if (_isVerified) ...[
              const SizedBox(width: 8),
              Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle),
                  child: Icon(Icons.check,
                      color: theme.colorScheme.onSecondary, size: 16)),
            ],
          ]),

          const SizedBox(height: 8),

          // Member Since Date
          Text('Member since August 2024',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ]));
  }

  void _showPhotoUpdateOptions() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          final theme = Theme.of(context);
          return Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2))),
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      Text('Update Profile Photo',
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 24),
                      _buildPhotoOption(
                          context: context,
                          icon: Icons.camera_alt_outlined,
                          title: 'Take Photo',
                          onTap: () {
                            Navigator.pop(context);
                            // TODO: Implement camera functionality
                          }),
                      const SizedBox(height: 16),
                      _buildPhotoOption(
                          context: context,
                          icon: Icons.photo_library_outlined,
                          title: 'Choose from Gallery',
                          onTap: () {
                            Navigator.pop(context);
                            // TODO: Implement gallery picker
                          }),
                      const SizedBox(height: 16),
                      _buildPhotoOption(
                          context: context,
                          icon: Icons.delete_outline,
                          title: 'Remove Photo',
                          isDestructive: true,
                          onTap: () {
                            Navigator.pop(context);
                            // TODO: Implement photo removal
                          }),
                    ])),
              ]));
        });
  }

  Widget _buildPhotoOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);

    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.2),
                    width: 1)),
            child: Row(children: [
              Icon(icon,
                  color: isDestructive
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface,
                  size: 24),
              const SizedBox(width: 16),
              Text(title,
                  style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDestructive
                          ? theme.colorScheme.error
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500)),
            ])));
  }
}