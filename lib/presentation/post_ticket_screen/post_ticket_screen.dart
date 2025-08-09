import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/contact_review_step.dart';
import './widgets/event_details_step.dart';
import './widgets/image_upload_step.dart';
import './widgets/progress_indicator_widget.dart';
import './widgets/ticket_details_step.dart';

class PostTicketScreen extends StatefulWidget {
  const PostTicketScreen({super.key});

  @override
  State<PostTicketScreen> createState() => _PostTicketScreenState();
}

class _PostTicketScreenState extends State<PostTicketScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isSubmitting = false;
  bool _isNewUser = true; // Simulating new user status

  final List<String> _stepTitles = [
    'Event Details',
    'Ticket Info',
    'Upload Image',
    'Review & Post'
  ];

  // Data storage for all steps
  final Map<String, dynamic> _formData = {};
  final Map<int, bool> _stepValidation = {
    0: false,
    1: false,
    2: false,
    3: false,
  };

  // Mock user data for posting limitations
  final Map<String, dynamic> _userData = {
    'isNewUser': true,
    'accountAge': 3, // days
    'ticketsPostedToday': 1,
    'totalTicketsPosted': 2,
    'verificationStatus': 'pending',
  };

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() {
    _isNewUser = (_userData['accountAge'] as int) < 7;
    if (_isNewUser && (_userData['ticketsPostedToday'] as int) >= 2) {
      _showPostingLimitDialog();
    }
  }

  void _showPostingLimitDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'info',
              color: AppTheme.warningYellow,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Posting Limit Reached',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Text(
          'New users can post up to 2 tickets per day for the first week. You\'ve reached today\'s limit. Please try again tomorrow.',
          style: AppTheme.lightTheme.textTheme.bodyMedium,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }

  void _onStepDataChanged(int stepIndex, Map<String, dynamic> data) {
    setState(() {
      _formData.addAll(data);
      _stepValidation[stepIndex] = _validateStep(stepIndex, data);
    });
  }

  bool _validateStep(int stepIndex, Map<String, dynamic> data) {
    switch (stepIndex) {
      case 0: // Event Details
        return data['eventName'] != null &&
            (data['eventName'] as String).isNotEmpty &&
            data['eventDate'] != null &&
            data['venue'] != null &&
            (data['venue'] as String).isNotEmpty &&
            data['category'] != null;
      case 1: // Ticket Details
        return data['section'] != null &&
            (data['section'] as String).isNotEmpty &&
            data['originalPrice'] != null &&
            data['sellingPrice'] != null &&
            data['quantity'] != null;
      case 2: // Image Upload
        return data['ticketImage'] != null;
      case 3: // Contact & Review
        return data['agreeToTerms'] == true;
      default:
        return false;
    }
  }

  bool get _canProceedToNext {
    return _stepValidation[_currentStep] == true;
  }

  void _nextStep() {
    if (_canProceedToNext && _currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  Future<void> _submitListing() async {
    if (!_stepValidation[3]!) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Simulate API submission
      await Future.delayed(const Duration(seconds: 3));

      // Simulate success
      HapticFeedback.heavyImpact();

      // Show success dialog
      _showSuccessDialog();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to submit listing. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.errorRed,
        textColor: AppTheme.pureWhite,
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.verificationGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: CustomIconWidget(
                iconName: 'check_circle',
                color: AppTheme.verificationGreen,
                size: 48,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              'Listing Submitted!',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              _isNewUser
                  ? 'Your listing is under review. New sellers require admin approval for their first 3 listings. You\'ll be notified within 2-4 hours.'
                  : 'Your ticket listing is now live! Buyers can contact you through the app.',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (_isNewUser) ...[
              SizedBox(height: 2.h),
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'schedule',
                      color: AppTheme.primaryBlue,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'Tracking ID: TG${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home-screen',
                (route) => false,
              );
            },
            child: const Text('Go to Home'),
          ),
        ],
      ),
    );
  }

  void _saveDraft() {
    Fluttertoast.showToast(
      msg: 'Draft saved successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppTheme.verificationGreen,
      textColor: AppTheme.pureWhite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.neutralGray,
      appBar: AppBar(
        title: const Text('Post Ticket'),
        backgroundColor: AppTheme.pureWhite,
        foregroundColor: AppTheme.textPrimary,
        elevation: 0,
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back_ios',
            color: AppTheme.textPrimary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _saveDraft,
            child: Text(
              'Save Draft',
              style: TextStyle(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          ProgressIndicatorWidget(
            currentStep: _currentStep,
            totalSteps: _stepTitles.length,
            stepTitles: _stepTitles,
          ),

          // New User Warning Banner
          if (_isNewUser && _currentStep == 0)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              color: AppTheme.warningYellow.withValues(alpha: 0.1),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info',
                    color: AppTheme.warningYellow,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'New user limit: 2 tickets per day for first week. ${2 - (_userData['ticketsPostedToday'] as int)} remaining today.',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Step Content
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                EventDetailsStep(
                  onDataChanged: (data) => _onStepDataChanged(0, data),
                  initialData: _formData,
                ),
                TicketDetailsStep(
                  onDataChanged: (data) => _onStepDataChanged(1, data),
                  initialData: _formData,
                ),
                ImageUploadStep(
                  onDataChanged: (data) => _onStepDataChanged(2, data),
                  initialData: _formData,
                ),
                ContactReviewStep(
                  onDataChanged: (data) => _onStepDataChanged(3, data),
                  allData: _formData,
                ),
              ],
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.pureWhite,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Back Button
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousStep,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          side: BorderSide(color: AppTheme.borderSubtle),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconWidget(
                              iconName: 'arrow_back_ios',
                              color: AppTheme.textPrimary,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            const Text('Back'),
                          ],
                        ),
                      ),
                    ),

                  if (_currentStep > 0) SizedBox(width: 4.w),

                  // Next/Submit Button
                  Expanded(
                    flex: _currentStep == 0 ? 1 : 1,
                    child: ElevatedButton(
                      onPressed: _isSubmitting
                          ? null
                          : (_currentStep == _stepTitles.length - 1
                              ? _submitListing
                              : _canProceedToNext
                                  ? _nextStep
                                  : null),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 3.h),
                        backgroundColor: _canProceedToNext ||
                                _currentStep == _stepTitles.length - 1
                            ? AppTheme.primaryBlue
                            : AppTheme.borderSubtle,
                        foregroundColor: _canProceedToNext ||
                                _currentStep == _stepTitles.length - 1
                            ? AppTheme.pureWhite
                            : AppTheme.textSecondary,
                      ),
                      child: _isSubmitting
                          ? SizedBox(
                              width: 5.w,
                              height: 5.w,
                              child: CircularProgressIndicator(
                                color: AppTheme.pureWhite,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _currentStep == _stepTitles.length - 1
                                      ? 'Submit Listing'
                                      : 'Next',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                if (_currentStep < _stepTitles.length - 1) ...[
                                  SizedBox(width: 2.w),
                                  CustomIconWidget(
                                    iconName: 'arrow_forward_ios',
                                    color: _canProceedToNext
                                        ? AppTheme.pureWhite
                                        : AppTheme.textSecondary,
                                    size: 16,
                                  ),
                                ],
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
