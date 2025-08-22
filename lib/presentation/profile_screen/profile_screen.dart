import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_bar.dart';
import './widgets/posted_tickets_section_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/statistics_section_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 4; // Profile tab index

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header with Avatar and Info
              const ProfileHeaderWidget(),

              const SizedBox(height: 24),

              // Statistics Section
              const StatisticsSectionWidget(),

              const SizedBox(height: 24),

              // Posted Tickets Section
              const PostedTicketsSectionWidget(),

              const SizedBox(height: 24),

              // Settings Section
              const SettingsSectionWidget(),

              const SizedBox(height: 100), // Bottom padding for navigation
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
