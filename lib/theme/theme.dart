import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme colorScheme = ColorScheme(
  primary: Color(0xFF53E88B),
  onPrimary: Color(0x1A53E88C),
  secondary: Color(0xFF2A2A2A),
  onSecondary: Color(0x4DFFFFFF),
  background: Color(0xFF0D0D0D),
  onBackground: Color.fromARGB(18, 255, 255, 255),
  surface: Color(0xFFFBFFFF),
  onSurface: Color(0xFFFEFEFF),
  error: Color(0xFFDA6317),
  onError: Color(0xFFF9A84D),
  brightness: Brightness.dark,
);

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: TextTheme(
        displayLarge: GoogleFonts.viga(
          fontSize: 38,
          color: colorScheme.primary,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        // bodyText1: TextStyle(color: Colors.white, fontSize: 16),
        // bodyText2: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme:
              IconThemeData(color: colorScheme.primary, size: 32),
          selectedItemColor: colorScheme.onPrimary,
          selectedLabelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorScheme.surface,
          ),
          unselectedIconTheme:
              IconThemeData(color: colorScheme.onPrimary, size: 32),
          backgroundColor: colorScheme.secondary,
          elevation: 3)
      //   color: Colors.black,
      //   iconTheme: IconThemeData(color: Colors.white),
      //   textTheme: TextTheme(
      //     headline6: TextStyle(color: Colors.white, fontSize: 20),
      //   ),
      // ),
      // buttonTheme: ButtonThemeData(
      //   buttonColor: colorScheme.primary,
      //   textTheme: ButtonTextTheme.primary,
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   border: OutlineInputBorder(),
      //   focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.red),
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.grey),
      //   ),
      // )
      );
}
