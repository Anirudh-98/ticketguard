import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ContactReviewStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> allData;

  const ContactReviewStep({
    super.key,
    required this.onDataChanged,
    required this.allData,
  });

  @override
  State<ContactReviewStep> createState() => _ContactReviewStepState();
}

class _ContactReviewStepState extends State<ContactReviewStep> {
  bool _allowDirectContact = true;
  bool _allowInAppMessaging = true;
  bool _agreeToTerms = false;
  String? _termsError;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _allowDirectContact = widget.allData['allowDirectContact'] ?? true;
    _allowInAppMessaging = widget.allData['allowInAppMessaging'] ?? true;
    _agreeToTerms = widget.allData['agreeToTerms'] ?? false;
  }

  void _validateAndUpdate() {
    setState(() {
      _termsError =
          !_agreeToTerms ? 'You must agree to the terms and conditions' : null;
    });

    widget.onDataChanged({
      'allowDirectContact': _allowDirectContact,
      'allowInAppMessaging': _allowInAppMessaging,
      'agreeToTerms': _agreeToTerms,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact & Review',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Set your contact preferences and review your listing',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),

          // Contact Preferences
          Text(
            'Contact Preferences',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),

          // In-App Messaging Option
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'chat',
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'In-App Messaging',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Allow buyers to message you through the app',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _allowInAppMessaging,
                  onChanged: (value) {
                    setState(() {
                      _allowInAppMessaging = value;
                    });
                    _validateAndUpdate();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),

          // Direct Contact Option
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.verificationGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'phone',
                    color: AppTheme.verificationGreen,
                    size: 20,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Direct Contact',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        'Show your phone number to interested buyers',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _allowDirectContact,
                  onChanged: (value) {
                    setState(() {
                      _allowDirectContact = value;
                    });
                    _validateAndUpdate();
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),

          // Listing Summary
          Text(
            'Listing Summary',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),

          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.pureWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderSubtle),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadowLight,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Info
                _buildSummaryRow(
                    'Event', widget.allData['eventName'] ?? 'Not specified'),
                _buildSummaryRow(
                    'Date',
                    widget.allData['eventDate'] != null
                        ? '${(widget.allData['eventDate'] as DateTime).month}/${(widget.allData['eventDate'] as DateTime).day}/${(widget.allData['eventDate'] as DateTime).year}'
                        : 'Not specified'),
                _buildSummaryRow(
                    'Venue', widget.allData['venue'] ?? 'Not specified'),
                _buildSummaryRow(
                    'Category', widget.allData['category'] ?? 'Not specified'),

                Divider(color: AppTheme.borderSubtle, height: 3.h),

                // Ticket Details
                _buildSummaryRow(
                    'Section', widget.allData['section'] ?? 'Not specified'),
                if (widget.allData['row'] != null &&
                    (widget.allData['row'] as String).isNotEmpty)
                  _buildSummaryRow('Row', widget.allData['row']),
                if (widget.allData['seat'] != null &&
                    (widget.allData['seat'] as String).isNotEmpty)
                  _buildSummaryRow('Seat', widget.allData['seat']),
                _buildSummaryRow(
                    'Quantity', '${widget.allData['quantity'] ?? 1} ticket(s)'),

                Divider(color: AppTheme.borderSubtle, height: 3.h),

                // Pricing
                _buildSummaryRow(
                    'Original Price',
                    widget.allData['originalPrice'] != null
                        ? '\$${(widget.allData['originalPrice'] as double).toStringAsFixed(2)} per ticket'
                        : 'Not specified'),
                _buildSummaryRow(
                    'Your Price',
                    widget.allData['sellingPrice'] != null
                        ? '\$${(widget.allData['sellingPrice'] as double).toStringAsFixed(2)} per ticket'
                        : 'Not specified',
                    isHighlight: true),

                if (widget.allData['quantity'] != null &&
                    widget.allData['sellingPrice'] != null)
                  _buildSummaryRow('Total Value',
                      '\$${((widget.allData['sellingPrice'] as double) * (widget.allData['quantity'] as int)).toStringAsFixed(2)}',
                      isHighlight: true),
              ],
            ),
          ),
          SizedBox(height: 4.h),

          // Terms and Conditions
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
                      iconName: 'info',
                      color: AppTheme.warningYellow,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Important Notice',
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.warningYellow,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  'New sellers: Your first 3 listings require admin approval. This typically takes 2-4 hours during business hours.',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),

          // Terms Agreement
          GestureDetector(
            onTap: () {
              setState(() {
                _agreeToTerms = !_agreeToTerms;
              });
              _validateAndUpdate();
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: BoxDecoration(
                    color: _agreeToTerms
                        ? AppTheme.verificationGreen
                        : AppTheme.pureWhite,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: _termsError != null
                          ? AppTheme.errorRed
                          : _agreeToTerms
                              ? AppTheme.verificationGreen
                              : AppTheme.borderSubtle,
                      width: 2,
                    ),
                  ),
                  child: _agreeToTerms
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: AppTheme.pureWhite,
                          size: 12,
                        )
                      : null,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                          children: [
                            const TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Community Guidelines',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(
                                text:
                                    '. I confirm that I own these tickets and they are legitimate.'),
                          ],
                        ),
                      ),
                      if (_termsError != null)
                        Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: Text(
                            _termsError!,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.errorRed,
                            ),
                          ),
                        ),
                    ],
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

  Widget _buildSummaryRow(String label, String value,
      {bool isHighlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 25.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color:
                    isHighlight ? AppTheme.primaryBlue : AppTheme.textPrimary,
                fontWeight: isHighlight ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
