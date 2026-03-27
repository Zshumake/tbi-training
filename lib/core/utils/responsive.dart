import 'package:flutter/widgets.dart';

class Responsive {
  static const double phoneBreak = 600;
  static const double tabletBreak = 1024;

  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < phoneBreak;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= phoneBreak &&
      MediaQuery.sizeOf(context).width < tabletBreak;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreak;

  /// Returns a value based on screen size
  static T value<T>(
    BuildContext context, {
    required T phone,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? phone;
    if (isTablet(context)) return tablet ?? phone;
    return phone;
  }

  /// Content padding that scales with screen size
  static EdgeInsets contentPadding(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal: value(context, phone: 16, tablet: 32, desktop: 48),
      );

  /// Number of columns for grid layouts
  static int gridColumns(BuildContext context) =>
      value(context, phone: 1, tablet: 2, desktop: 3);
}
