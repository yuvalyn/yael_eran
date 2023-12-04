import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String appName;
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final String logoPath;

  static AppConfig? _instance;

  AppConfig._internal({
    required this.appName,
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.logoPath,
  });

  factory AppConfig(
      {required String appName,
      required Color primaryColor,
      required Color secondaryColor,
      required Color tertiaryColor,
      required String logoPath}) {
    _instance ??= AppConfig._internal(
      appName: appName,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      tertiaryColor: tertiaryColor,
      logoPath: logoPath,
    );
    return _instance!;
  }

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception('AppConfig is not initialized');
    }
    return _instance!;
  }

  static Future<AppConfig> initialize() async {
    if (_instance != null) {
      return _instance!;
    }

    final configString =
        await rootBundle.loadString('assets/config/config.json');
    final configJson = json.decode(configString);
    return AppConfig.fromJson(configJson);
  }

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['app_name'],
      primaryColor: _parseColor(json['primary_color']),
      secondaryColor: _parseColor(json['secondary_color']),
      tertiaryColor: _parseColor(json['tertiary_color']),
      logoPath: json['logo_path'],
    );
  }

  static Color _parseColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
