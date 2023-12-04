import 'package:flutter/material.dart';

import 'models/app_config.dart';

class AppTheme {

  static ThemeData get theme  {
    AppConfig config =  AppConfig.instance;
    return ThemeData(
      primaryColor: config.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.grey),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: config.primaryColor), // Color for focused input line
        ),

      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: config.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
            side: const BorderSide(
                color: Colors.blueGrey, width: 1.0), // Border
          ),
          // Text color for ElevatedButton
        ),
      ),
      floatingActionButtonTheme:  FloatingActionButtonThemeData(
        backgroundColor: config.primaryColor,
        foregroundColor: Colors.white,
      ),
    );

  }
}