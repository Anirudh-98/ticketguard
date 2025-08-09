import 'dart:io' if (dart.library.io) 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ImageUploadStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialData;

  const ImageUploadStep({
    super.key,
    required this.onDataChanged,
    required this.initialData,
  });

  @override
  State<ImageUploadStep> createState() => _ImageUploadStepState();
}

class _ImageUploadStepState extends State<ImageUploadStep> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isUploading = false;
  bool _isValidating = false;
  String? _validationMessage;
  String? _imageError;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.initialData['ticketImage'] != null) {
      _selectedImage = widget.initialData['ticketImage'] as XFile?;
    }
  }

  Future<bool> _requestPermissions() async {
    if (kIsWeb) return true;

    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    return cameraStatus.isGranted && storageStatus.isGranted;
  }

  Future<void> _pickImageFromCamera() async {
    if (!await _requestPermissions()) {
      _showPermissionDialog();
      return;
    }

    setState(() {
      _isUploading = true;
      _imageError = null;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        await _processImage(image);
      }
    } catch (e) {
      setState(() {
        _imageError = 'Failed to capture image. Please try again.';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    if (!await _requestPermissions()) {
      _showPermissionDialog();
      return;
    }

    setState(() {
      _isUploading = true;
      _imageError = null;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        await _processImage(image);
      }
    } catch (e) {
      setState(() {
        _imageError = 'Failed to select image. Please try again.';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _processImage(XFile image) async {
    setState(() {
      _isValidating = true;
      _validationMessage = 'Validating image quality...';
    });

    // Simulate image validation process
    await Future.delayed(const Duration(seconds: 2));

    // Check file size
    final bytes = await image.readAsBytes();
    if (bytes.length > 10 * 1024 * 1024) {
      // 10MB limit
      setState(() {
        _imageError = 'Image size must be less than 10MB';
        _isValidating = false;
        _validationMessage = null;
      });
      return;
    }

    // Simulate quality validation
    setState(() {
      _validationMessage = 'Checking for duplicates...';
    });
    await Future.delayed(const Duration(seconds: 1));

    // Simulate duplicate detection
    final isDuplicate =
        DateTime.now().millisecond % 10 == 0; // 10% chance of duplicate
    if (isDuplicate) {
      setState(() {
        _imageError =
            'This image appears to be a duplicate. Please use a different image.';
        _isValidating = false;
        _validationMessage = null;
      });
      return;
    }

    setState(() {
      _selectedImage = image;
      _isValidating = false;
      _validationMessage = 'Image validated successfully!';
      _imageError = null;
    });

    // Clear success message after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _validationMessage = null;
        });
      }
    });

    widget.onDataChanged({
      'ticketImage': image,
    });
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
      _imageError = null;
      _validationMessage = null;
    });
    widget.onDataChanged({
      'ticketImage': null,
    });
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Permissions Required',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        content: Text(
          'Camera and storage permissions are required to upload ticket images.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Select Image Source',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'camera_alt',
                  color: AppTheme.primaryBlue,
                  size: 24,
                ),
              ),
              title: Text(
                'Camera',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'Take a new photo',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.verificationGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'photo_library',
                  color: AppTheme.verificationGreen,
                  size: 24,
                ),
              ),
              title: Text(
                'Gallery',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              subtitle: Text(
                'Choose from existing photos',
                style: AppTheme.lightTheme.textTheme.bodySmall,
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImageFromGallery();
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket Image',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Upload a clear photo of your ticket for verification',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),

          // Image Upload Area
          if (_selectedImage == null) ...[
            GestureDetector(
              onTap: _isUploading ? null : _showImageSourceDialog,
              child: Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppTheme.neutralGray,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _imageError != null
                        ? AppTheme.errorRed
                        : AppTheme.borderSubtle,
                    style: BorderStyle.solid,
                  ),
                ),
                child: _isUploading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 8.w,
                            height: 8.w,
                            child: CircularProgressIndicator(
                              color: AppTheme.primaryBlue,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Processing image...',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color:
                                  AppTheme.primaryBlue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CustomIconWidget(
                              iconName: 'add_photo_alternate',
                              color: AppTheme.primaryBlue,
                              size: 32,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Upload Ticket Image',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Tap to select from camera or gallery',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: AppTheme.pureWhite,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppTheme.borderSubtle),
                            ),
                            child: Text(
                              'JPG, PNG • Max 10MB',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ] else ...[
            // Image Preview
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderSubtle),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    if (kIsWeb)
                      Image.network(
                        _selectedImage!.path,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppTheme.neutralGray,
                            child: Center(
                              child: CustomIconWidget(
                                iconName: 'broken_image',
                                color: AppTheme.textSecondary,
                                size: 48,
                              ),
                            ),
                          );
                        },
                      )
                    else
                      Image.file(
                        File(_selectedImage!.path),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppTheme.neutralGray,
                            child: Center(
                              child: CustomIconWidget(
                                iconName: 'broken_image',
                                color: AppTheme.textSecondary,
                                size: 48,
                              ),
                            ),
                          );
                        },
                      ),
                    Positioned(
                      top: 2.w,
                      right: 2.w,
                      child: GestureDetector(
                        onTap: _removeImage,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: AppTheme.errorRed,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: AppTheme.pureWhite,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            ElevatedButton.icon(
              onPressed: _showImageSourceDialog,
              icon: CustomIconWidget(
                iconName: 'edit',
                color: AppTheme.pureWhite,
                size: 16,
              ),
              label: const Text('Change Image'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: AppTheme.pureWhite,
              ),
            ),
          ],

          // Validation Status
          if (_isValidating) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 4.w,
                    height: 4.w,
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryBlue,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      _validationMessage ?? 'Validating...',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Success Message
          if (_validationMessage != null && !_isValidating) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.verificationGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: AppTheme.verificationGreen.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'check_circle',
                    color: AppTheme.verificationGreen,
                    size: 16,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      _validationMessage!,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.verificationGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Error Message
          if (_imageError != null) ...[
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: AppTheme.errorRed.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'error',
                    color: AppTheme.errorRed,
                    size: 16,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      _imageError!,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.errorRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Image Guidelines
          SizedBox(height: 3.h),
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.warningYellow.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppTheme.warningYellow.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'tips_and_updates',
                      color: AppTheme.warningYellow,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Image Guidelines',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningYellow,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  '• Ensure ticket details are clearly visible\n• Avoid blurry or dark images\n• Include barcode/QR code if present\n• No personal information should be visible',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
