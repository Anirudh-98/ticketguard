import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TicketDetailsStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialData;

  const TicketDetailsStep({
    super.key,
    required this.onDataChanged,
    required this.initialData,
  });

  @override
  State<TicketDetailsStep> createState() => _TicketDetailsStepState();
}

class _TicketDetailsStepState extends State<TicketDetailsStep> {
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _seatController = TextEditingController();
  final TextEditingController _originalPriceController =
      TextEditingController();
  final TextEditingController _sellingPriceController = TextEditingController();

  int _quantity = 1;
  String? _sectionError;
  String? _originalPriceError;
  String? _sellingPriceError;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _sectionController.text = widget.initialData['section'] ?? '';
    _rowController.text = widget.initialData['row'] ?? '';
    _seatController.text = widget.initialData['seat'] ?? '';
    _originalPriceController.text =
        widget.initialData['originalPrice']?.toString() ?? '';
    _sellingPriceController.text =
        widget.initialData['sellingPrice']?.toString() ?? '';
    _quantity = widget.initialData['quantity'] ?? 1;
  }

  void _validateAndUpdate() {
    setState(() {
      _sectionError =
          _sectionController.text.trim().isEmpty ? 'Section is required' : null;

      double? originalPrice = double.tryParse(_originalPriceController.text);
      _originalPriceError = originalPrice == null || originalPrice <= 0
          ? 'Valid original price is required'
          : null;

      double? sellingPrice = double.tryParse(_sellingPriceController.text);
      if (sellingPrice == null || sellingPrice <= 0) {
        _sellingPriceError = 'Valid selling price is required';
      } else if (originalPrice != null && sellingPrice > originalPrice * 1.5) {
        _sellingPriceError =
            'Selling price cannot exceed 150% of original price';
      } else {
        _sellingPriceError = null;
      }
    });

    if (_sectionError == null &&
        _originalPriceError == null &&
        _sellingPriceError == null) {
      widget.onDataChanged({
        'section': _sectionController.text.trim(),
        'row': _rowController.text.trim(),
        'seat': _seatController.text.trim(),
        'quantity': _quantity,
        'originalPrice': double.tryParse(_originalPriceController.text),
        'sellingPrice': double.tryParse(_sellingPriceController.text),
      });
    }
  }

  void _updateQuantity(int delta) {
    setState(() {
      _quantity = (_quantity + delta).clamp(1, 8);
    });
    _validateAndUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket Details',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Provide specific information about your tickets',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),

          // Section Field
          Text(
            'Section *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          TextFormField(
            controller: _sectionController,
            decoration: InputDecoration(
              hintText: 'e.g., 101, Floor, VIP',
              errorText: _sectionError,
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'confirmation_number',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) => _validateAndUpdate(),
          ),
          SizedBox(height: 3.h),

          // Row and Seat Fields
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Row',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: _rowController,
                      decoration: InputDecoration(
                        hintText: 'e.g., A, 12',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'table_rows',
                            color: AppTheme.textSecondary,
                            size: 20,
                          ),
                        ),
                      ),
                      onChanged: (value) => _validateAndUpdate(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seat',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    TextFormField(
                      controller: _seatController,
                      decoration: InputDecoration(
                        hintText: 'e.g., 15, 16',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'chair',
                            color: AppTheme.textSecondary,
                            size: 20,
                          ),
                        ),
                      ),
                      onChanged: (value) => _validateAndUpdate(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),

          // Quantity Stepper
          Text(
            'Quantity',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderSubtle),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'confirmation_number',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Number of tickets',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.pureWhite,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _updateQuantity(-1),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'remove',
                            color: _quantity > 1
                                ? AppTheme.primaryBlue
                                : AppTheme.textSecondary,
                            size: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: Text(
                          _quantity.toString(),
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _updateQuantity(1),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'add',
                            color: _quantity < 8
                                ? AppTheme.primaryBlue
                                : AppTheme.textSecondary,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),

          // Original Price Field
          Text(
            'Original Price (\$ per ticket) *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          TextFormField(
            controller: _originalPriceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: '0.00',
              errorText: _originalPriceError,
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'attach_money',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) => _validateAndUpdate(),
          ),
          SizedBox(height: 3.h),

          // Selling Price Field
          Text(
            'Your Selling Price (\$ per ticket) *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          TextFormField(
            controller: _sellingPriceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            decoration: InputDecoration(
              hintText: '0.00',
              errorText: _sellingPriceError,
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'sell',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) => _validateAndUpdate(),
          ),

          // Price Validation Info
          if (_originalPriceController.text.isNotEmpty &&
              _sellingPriceController.text.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 2.h),
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
                    iconName: 'info',
                    color: AppTheme.verificationGreen,
                    size: 16,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      'Maximum allowed selling price: \$${(double.tryParse(_originalPriceController.text) ?? 0 * 1.5).toStringAsFixed(2)}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.verificationGreen,
                      ),
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

  @override
  void dispose() {
    _sectionController.dispose();
    _rowController.dispose();
    _seatController.dispose();
    _originalPriceController.dispose();
    _sellingPriceController.dispose();
    super.dispose();
  }
}
