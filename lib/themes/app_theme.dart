import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static Color seedColor = const Color.fromARGB(255, 0, 255, 145);

  static ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: GoogleFonts.juraTextTheme(ThemeData.light().textTheme),
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ).primaryContainer,
      // foregroundColor: Colors.black,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.juraTextTheme(ThemeData.dark().textTheme),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF001212),
    appBarTheme: AppBarTheme(
      backgroundColor: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ).primaryContainer,
      // foregroundColor: Colors.black,
      elevation: 0,
    ),
  );
}
