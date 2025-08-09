import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the ticket marketplace application.
/// Implements Contemporary Trust Minimalism design with Professional Confidence Palette.
class AppTheme {
  AppTheme._();

  // Professional Confidence Palette - Trust-building colors optimized for mobile
  static const Color primaryBlue = Color(0xFF2D9CDB);
  static const Color verificationGreen = Color(0xFF27AE60);
  static const Color warningYellow = Color(0xFFF2C94C);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color neutralGray = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color borderSubtle = Color(0xFFE5E7EB);
  static const Color errorRed = Color(0xFFDC2626);
  static const Color successAccent = Color(0xFF059669);

  // Dark theme variations
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2D2D2D);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color borderSubtleDark = Color(0xFF404040);

  // Shadow colors for subtle elevation
  static const Color shadowLight = Color(0x33000000); // 20% opacity
  static const Color shadowDark = Color(0x33FFFFFF);

  /// Light theme - Contemporary Trust Minimalism
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryBlue,
      onPrimary: pureWhite,
      primaryContainer: primaryBlue.withValues(alpha: 0.1),
      onPrimaryContainer: primaryBlue,
      secondary: verificationGreen,
      onSecondary: pureWhite,
      secondaryContainer: verificationGreen.withValues(alpha: 0.1),
      onSecondaryContainer: verificationGreen,
      tertiary: successAccent,
      onTertiary: pureWhite,
      tertiaryContainer: successAccent.withValues(alpha: 0.1),
      onTertiaryContainer: successAccent,
      error: errorRed,
      onError: pureWhite,
      surface: pureWhite,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      outline: borderSubtle,
      outlineVariant: borderSubtle.withValues(alpha: 0.5),
      shadow: shadowLight,
      scrim: textPrimary.withValues(alpha: 0.5),
      inverseSurface: textPrimary,
      onInverseSurface: pureWhite,
      inversePrimary: primaryBlue.withValues(alpha: 0.8),
    ),
    scaffoldBackgroundColor: pureWhite,
    cardColor: pureWhite,
    dividerColor: borderSubtle,

    // AppBar theme - Clean and trustworthy
    appBarTheme: AppBarTheme(
      backgroundColor: pureWhite,
      foregroundColor: textPrimary,
      elevation: 0,
      shadowColor: shadowLight,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: -0.2,
      ),
      iconTheme: const IconThemeData(
        color: textPrimary,
        size: 24,
      ),
    ),

    // Card theme - Subtle elevation for trust
    cardTheme: CardTheme(
      color: pureWhite,
      elevation: 2,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    // Bottom navigation - Mobile-optimized trust indicators
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: pureWhite,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textSecondary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Floating action button - Trust-building primary
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      foregroundColor: pureWhite,
      elevation: 4,
      shape: CircleBorder(),
    ),

    // Button themes - Contemporary and accessible
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: pureWhite,
        elevation: 2,
        shadowColor: shadowLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: primaryBlue, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),

    // Typography - Inter font family for exceptional mobile legibility
    textTheme: _buildTextTheme(isLight: true),

    // Input decoration - Trust-building form elements
    inputDecorationTheme: InputDecorationTheme(
      fillColor: neutralGray,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),

    // Interactive elements - Verification-focused
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen;
        }
        return borderSubtle;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen.withValues(alpha: 0.3);
        }
        return borderSubtle.withValues(alpha: 0.5);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(pureWhite),
      side: const BorderSide(color: borderSubtle, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen;
        }
        return borderSubtle;
      }),
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryBlue,
      linearTrackColor: borderSubtle,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primaryBlue,
      thumbColor: primaryBlue,
      overlayColor: primaryBlue.withValues(alpha: 0.2),
      inactiveTrackColor: borderSubtle,
    ),

    tabBarTheme: TabBarTheme(
      labelColor: primaryBlue,
      unselectedLabelColor: textSecondary,
      indicatorColor: primaryBlue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: pureWhite,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: GoogleFonts.inter(
        color: pureWhite,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
    ), dialogTheme: DialogThemeData(backgroundColor: pureWhite),
  );

  /// Dark theme - Contemporary Trust Minimalism for dark mode
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryBlue,
      onPrimary: textPrimary,
      primaryContainer: primaryBlue.withValues(alpha: 0.2),
      onPrimaryContainer: primaryBlue,
      secondary: verificationGreen,
      onSecondary: textPrimary,
      secondaryContainer: verificationGreen.withValues(alpha: 0.2),
      onSecondaryContainer: verificationGreen,
      tertiary: successAccent,
      onTertiary: textPrimary,
      tertiaryContainer: successAccent.withValues(alpha: 0.2),
      onTertiaryContainer: successAccent,
      error: errorRed,
      onError: pureWhite,
      surface: surfaceDark,
      onSurface: textPrimaryDark,
      onSurfaceVariant: textSecondaryDark,
      outline: borderSubtleDark,
      outlineVariant: borderSubtleDark.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: textPrimaryDark.withValues(alpha: 0.5),
      inverseSurface: pureWhite,
      onInverseSurface: textPrimary,
      inversePrimary: primaryBlue,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: borderSubtleDark,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: textPrimaryDark,
      elevation: 0,
      shadowColor: shadowDark,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textPrimaryDark,
        letterSpacing: -0.2,
      ),
      iconTheme: const IconThemeData(
        color: textPrimaryDark,
        size: 24,
      ),
    ),
    cardTheme: CardTheme(
      color: cardDark,
      elevation: 2,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryBlue,
      unselectedItemColor: textSecondaryDark,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      foregroundColor: pureWhite,
      elevation: 4,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: pureWhite,
        elevation: 2,
        shadowColor: shadowDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        side: const BorderSide(color: primaryBlue, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtleDark),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderSubtleDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorRed, width: 2),
      ),
      labelStyle: GoogleFonts.inter(
        color: textSecondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textSecondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen;
        }
        return borderSubtleDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen.withValues(alpha: 0.3);
        }
        return borderSubtleDark.withValues(alpha: 0.5);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(textPrimary),
      side: const BorderSide(color: borderSubtleDark, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return verificationGreen;
        }
        return borderSubtleDark;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryBlue,
      linearTrackColor: borderSubtleDark,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryBlue,
      thumbColor: primaryBlue,
      overlayColor: primaryBlue.withValues(alpha: 0.2),
      inactiveTrackColor: borderSubtleDark,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryBlue,
      unselectedLabelColor: textSecondaryDark,
      indicatorColor: primaryBlue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimaryDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: textPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cardDark,
      contentTextStyle: GoogleFonts.inter(
        color: textPrimaryDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: primaryBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 4,
    ), dialogTheme: DialogThemeData(backgroundColor: cardDark),
  );

  /// Helper method to build text theme with Inter font family
  /// Optimized for mobile readability and trust-building hierarchy
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHigh = isLight ? textPrimary : textPrimaryDark;
    final Color textMedium = isLight ? textSecondary : textSecondaryDark;
    final Color textDisabled = isLight
        ? textSecondary.withValues(alpha: 0.6)
        : textSecondaryDark.withValues(alpha: 0.6);

    return TextTheme(
      // Display styles - Large headings for key sections
      displayLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textHigh,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHigh,
        letterSpacing: -0.3,
        height: 1.3,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHigh,
        letterSpacing: -0.2,
        height: 1.3,
      ),

      // Headline styles - Section headers and important content
      headlineLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textHigh,
        letterSpacing: -0.1,
        height: 1.4,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textHigh,
        height: 1.4,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textHigh,
        height: 1.4,
      ),

      // Title styles - Card titles and form labels
      titleLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textHigh,
        letterSpacing: 0.1,
        height: 1.5,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHigh,
        letterSpacing: 0.1,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textHigh,
        letterSpacing: 0.2,
        height: 1.5,
      ),

      // Body styles - Main content and descriptions
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHigh,
        letterSpacing: 0.1,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHigh,
        letterSpacing: 0.1,
        height: 1.6,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMedium,
        letterSpacing: 0.2,
        height: 1.6,
      ),

      // Label styles - Buttons and interactive elements
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHigh,
        letterSpacing: 0.3,
        height: 1.4,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMedium,
        letterSpacing: 0.3,
        height: 1.4,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 0.4,
        height: 1.4,
      ),
    );
  }
}
