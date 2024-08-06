import "package:flutter/material.dart";

final theme = ThemeData(
  fontFamily: "Albert Sans",
  scaffoldBackgroundColor: const Color.fromRGBO(251, 251, 251, 1),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 40, height: 1.2),
    displayMedium: TextStyle(fontSize: 32, height: 1.25),
    displaySmall: TextStyle(fontSize: 26, height: 1.23),
    titleLarge: TextStyle(fontSize: 24, height: 1.33),
    titleMedium: TextStyle(fontSize: 20, height: 1.2),
    titleSmall: TextStyle(fontSize: 18, height: 1.33),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    bodyMedium: TextStyle(fontSize: 14, height: 1.43),
    bodySmall: TextStyle(fontSize: 12, height: 1.5),
    labelLarge: TextStyle(fontSize: 16, height: 1.5),
    labelMedium: TextStyle(fontSize: 14, height: 1.43),
    labelSmall: TextStyle(fontSize: 12, height: 1.5),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(19, 154, 67, 1),
    secondary: Color.fromRGBO(255, 159, 28, 1),
    tertiary: Color.fromRGBO(8, 65, 28, 1),
    onPrimary: Color.fromRGBO(255, 255, 255, 1),
    onSecondary: Color.fromRGBO(0, 0, 0, 1),
    onPrimaryContainer: Color.fromRGBO(230, 236, 232, 1),
    error: Color.fromRGBO(229, 77, 77, 1),
    onError: Color.fromRGBO(255, 255, 255, 1),
    background: Color.fromRGBO(251, 251, 251, 1),
    onBackground: Color.fromRGBO(178, 196, 185, 1),
    surface: Color.fromRGBO(255, 255, 255, 1),
    onSurface: Color.fromRGBO(16, 9, 3, 1),
    shadow: Color.fromRGBO(0, 0, 0, 0.1),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: Color.fromRGBO(230, 236, 232, 1),
        width: 1.0,
      ),
    ),
    outlineBorder: BorderSide.none,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: Color.fromRGBO(19, 154, 67, 1),
        width: 1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: Color.fromRGBO(229, 77, 77, 1),
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(
        color: Color.fromRGBO(229, 77, 77, 1),
        width: 1,
      ),
    ),
    errorStyle: TextStyle(
      color: Color.fromRGBO(224, 44, 0, 1),
      fontSize: 14.0,
      height: 1.43,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      color: Color.fromRGBO(178, 196, 185, 1),
      fontSize: 16.0,
      height: 1.5,
      fontWeight: FontWeight.w500,
    ),
    contentPadding: EdgeInsets.all(16.0),
    filled: true,
    fillColor: Color.fromRGBO(255, 255, 255, 1),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Color.fromRGBO(19, 154, 67, 1),
    unselectedLabelColor: Color.fromRGBO(178, 196, 185, 1),
    labelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.43,
    ),
    dividerHeight: 0,
    dividerColor: Colors.transparent,
    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
    tabAlignment: TabAlignment.start,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    constraints: BoxConstraints(maxHeight: 70),
    shape: LinearBorder(),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    circularTrackColor: Color.fromRGBO(255, 255, 255, 0.5),
  ),
  listTileTheme: ListTileThemeData(
    tileColor: Colors.white,
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        color: Color.fromRGBO(230, 236, 232, 1),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.all(16.0),
    titleTextStyle: const TextStyle(
      fontSize: 24,
      height: 1.33,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(8, 65, 28, 1),
    ),
  ),
);
