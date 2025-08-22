import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EventDetailsStep extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;
  final Map<String, dynamic> initialData;

  const EventDetailsStep({
    super.key,
    required this.onDataChanged,
    required this.initialData,
  });

  @override
  State<EventDetailsStep> createState() => _EventDetailsStepState();
}

class _EventDetailsStepState extends State<EventDetailsStep> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedCategory;

  final List<String> _eventCategories = [
    'Concert',
    'Sports',
    'Theater',
    'Comedy',
    'Festival',
    'Conference',
    'Other'
  ];

  final List<String> _eventSuggestions = [
    'Taylor Swift - The Eras Tour',
    'NBA Finals Game 7',
    'Hamilton Musical',
    'Coachella Music Festival',
    'Super Bowl LVIII',
    'Broadway Lion King',
    'UFC Championship Fight',
    'Marvel Movie Premiere'
  ];

  String? _eventNameError;
  String? _dateError;
  String? _venueError;
  String? _categoryError;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _eventNameController.text = widget.initialData['eventName'] ?? '';
    _venueController.text = widget.initialData['venue'] ?? '';
    _selectedDate = widget.initialData['eventDate'];
    _selectedCategory = widget.initialData['category'];
  }

  void _validateAndUpdate() {
    setState(() {
      _eventNameError = _eventNameController.text.trim().isEmpty
          ? 'Event name is required'
          : null;
      _dateError = _selectedDate == null
          ? 'Event date is required'
          : _selectedDate!.isBefore(DateTime.now())
              ? 'Event date must be in the future'
              : null;
      _venueError =
          _venueController.text.trim().isEmpty ? 'Venue is required' : null;
      _categoryError =
          _selectedCategory == null ? 'Category is required' : null;
    });

    if (_eventNameError == null &&
        _dateError == null &&
        _venueError == null &&
        _categoryError == null) {
      widget.onDataChanged({
        'eventName': _eventNameController.text.trim(),
        'eventDate': _selectedDate,
        'venue': _venueController.text.trim(),
        'category': _selectedCategory,
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppTheme.primaryBlue,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _validateAndUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Details',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Tell us about the event you\'re selling tickets for',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 4.h),

          // Event Name Field with Autocomplete
          Text(
            'Event Name *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.isEmpty) {
                return const Iterable<String>.empty();
              }
              return _eventSuggestions.where((String option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              _eventNameController.text = selection;
              _validateAndUpdate();
            },
            fieldViewBuilder:
                (context, controller, focusNode, onFieldSubmitted) {
              // Fix: Don't reassign the controller text, just sync it properly
              if (_eventNameController.text != controller.text) {
                controller.text = _eventNameController.text;
              }

              return TextFormField(
                controller: controller, // Use the provided controller
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: 'e.g., Taylor Swift - The Eras Tour',
                  errorText: _eventNameError,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'event',
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
                onChanged: (value) {
                  // Update our main controller when the field changes
                  _eventNameController.text = value;
                  _validateAndUpdate();
                },
              );
            },
          ),
          SizedBox(height: 3.h),

          // Event Date Field
          Text(
            'Event Date *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          GestureDetector(
            onTap: _selectDate,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppTheme.neutralGray,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _dateError != null
                      ? AppTheme.errorRed
                      : AppTheme.borderSubtle,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'calendar_today',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      _selectedDate != null
                          ? '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}'
                          : 'Select event date',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: _selectedDate != null
                            ? AppTheme.textPrimary
                            : AppTheme.textSecondary,
                      ),
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'keyboard_arrow_down',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (_dateError != null)
            Padding(
              padding: EdgeInsets.only(top: 1.h, left: 4.w),
              child: Text(
                _dateError!,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ),
          SizedBox(height: 3.h),

          // Venue Field
          Text(
            'Venue *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          TextFormField(
            controller: _venueController,
            decoration: InputDecoration(
              hintText: 'e.g., Madison Square Garden, New York',
              errorText: _venueError,
              prefixIcon: Padding(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: 'location_on',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
              ),
            ),
            onChanged: (value) => _validateAndUpdate(),
          ),
          SizedBox(height: 3.h),

          // Category Selection
          Text(
            'Category *',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
              color: AppTheme.neutralGray,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _categoryError != null
                    ? AppTheme.errorRed
                    : AppTheme.borderSubtle,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCategory,
                hint: Text(
                  'Select event category',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                icon: CustomIconWidget(
                  iconName: 'keyboard_arrow_down',
                  color: AppTheme.textSecondary,
                  size: 20,
                ),
                isExpanded: true,
                items: _eventCategories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(
                      category,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                  _validateAndUpdate();
                },
              ),
            ),
          ),
          if (_categoryError != null)
            Padding(
              padding: EdgeInsets.only(top: 1.h, left: 4.w),
              child: Text(
                _categoryError!,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _venueController.dispose();
    super.dispose();
  }
}
