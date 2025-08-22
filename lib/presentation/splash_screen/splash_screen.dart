import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _backgroundAnimationController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _backgroundOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashSequence();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // Background animation controller
    _backgroundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo fade-in animation
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    // Logo scale bounce animation
    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
    ));

    // Background pattern opacity animation
    _backgroundOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void _startSplashSequence() async {
    // Start background animation immediately
    _backgroundAnimationController.forward();

    // Start logo animation with slight delay
    await Future.delayed(const Duration(milliseconds: 300));
    _logoAnimationController.forward();

    // Navigate to home after minimum display time
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBlue,
      body: Stack(
        children: [
          // Background ticket pattern
          AnimatedBuilder(
            animation: _backgroundOpacityAnimation,
            builder: (context, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  image: _backgroundOpacityAnimation.value > 0
                      ? DecorationImage(
                          image: const AssetImage('assets/images/no-image.jpg'),
                          fit: BoxFit.cover,
                          opacity: _backgroundOpacityAnimation.value,
                        )
                      : null,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.primaryBlue.withValues(alpha: 0.9),
                        AppTheme.primaryBlue,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Main content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacer to center content
                  const Spacer(flex: 2),

                  // Animated logo section
                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _logoFadeAnimation,
                      _logoScaleAnimation,
                    ]),
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoFadeAnimation.value,
                        child: Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              color: AppTheme.pureWhite,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.shadowLight
                                      .withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(5.w),
                            child: SvgPicture.asset(
                              'assets/images/img_app_logo.svg',
                              width: 18.w,
                              height: 18.w,
                              colorFilter: const ColorFilter.mode(
                                AppTheme.primaryBlue,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 6.h),

                  // App name
                  AnimatedBuilder(
                    animation: _logoFadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoFadeAnimation.value,
                        child: Text(
                          'TicketGuard',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                color: AppTheme.pureWhite,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 2.h),

                  // Tagline
                  AnimatedBuilder(
                    animation: _logoFadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoFadeAnimation.value * 0.8,
                        child: Text(
                          'Secure Ticket Trading',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color:
                                    AppTheme.pureWhite.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                              ),
                        ),
                      );
                    },
                  ),

                  const Spacer(flex: 1),

                  // Loading indicator
                  AnimatedBuilder(
                    animation: _logoFadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _logoFadeAnimation.value,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 8.w,
                                height: 8.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.pureWhite.withValues(alpha: 0.8),
                                  ),
                                  backgroundColor:
                                      AppTheme.pureWhite.withValues(alpha: 0.2),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                'Loading your secure marketplace...',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppTheme.pureWhite
                                          .withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 6.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
