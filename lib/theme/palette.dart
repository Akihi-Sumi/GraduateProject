import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Palette {
  // Colors
  static const blackColor = Colors.black; // primary color
  static const greyColor = Colors.grey; // secondary color
  static const drawerColor = Color.fromRGBO(28, 28, 28, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  static var appColor = Colors.orange.shade700;

  // Themes
  static var darkModeAppTheme = ThemeData.dark(useMaterial3: false).copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: blackColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: whiteColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    iconTheme: IconThemeData(
      color: whiteColor,
      size: 24,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    colorScheme: ColorScheme(
      primary: appColor,
      onPrimary: whiteColor,
      secondary: Color(0xfff57c00),
      onSecondary: whiteColor,
      error: Color(0xffc62828),
      onError: whiteColor,
      surface: blackColor,
      onSurface: whiteColor,
      background: drawerColor,
      onBackground: whiteColor,
      brightness: Brightness.dark,
    ),
    canvasColor: Colors.transparent,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: whiteColor,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: whiteColor,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      textColor: whiteColor,
      collapsedTextColor: whiteColor,
      iconColor: whiteColor,
      collapsedIconColor: whiteColor,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.grey.shade800,
      headerBackgroundColor: appColor,
      headerHeadlineStyle: TextStyle(color: Colors.black),
      dayOverlayColor: MaterialStateProperty.resolveWith(
        (states) => appColor,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => greyColor,
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => appColor,
        ),
      ),
    ),
  );

  static var lightModeAppTheme = ThemeData.light(useMaterial3: false).copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: Colors.grey.shade200,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    iconTheme: IconThemeData(
      color: blackColor,
      size: 24,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    colorScheme: ColorScheme(
      primary: appColor,
      onPrimary: blackColor,
      secondary: Color(0xfff57c00),
      onSecondary: Colors.black,
      error: Color(0xffc62828),
      onError: whiteColor,
      surface: whiteColor,
      onSurface: blackColor,
      background: whiteColor,
      onBackground: Colors.black,
      brightness: Brightness.light,
    ),
    canvasColor: Colors.transparent,
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    expansionTileTheme: ExpansionTileThemeData(
      textColor: blackColor,
      collapsedTextColor: blackColor,
      iconColor: blackColor,
      collapsedIconColor: blackColor,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade700,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: appColor,
      headerHeadlineStyle: TextStyle(color: Colors.black),
      dayOverlayColor: MaterialStateProperty.resolveWith(
        (states) => appColor,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => greyColor,
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => appColor,
        ),
      ),
    ),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Palette.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Palette.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Palette.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Palette.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Palette.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
