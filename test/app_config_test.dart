import 'package:flutter_test/flutter_test.dart';
import 'package:employee_app/models/app_config.dart';
import 'package:flutter/material.dart';

void main() {
  group('AppConfig Tests', () {
    test('Should parse JSON and create AppConfig', () {
      final json = {
        'app_name': 'Test App',
        'primary_color': '#FFFFFF',
        'secondary_color': '#000000',
        'tertiary_color': '#FF0000',
        'logo_path': 'path/to/logo',
      };

      final config = AppConfig.fromJson(json);

      expect(config.appName, 'Test App');
      expect(config.primaryColor, isA<Color>());
      expect(config.secondaryColor, isA<Color>());
      expect(config.tertiaryColor, isA<Color>());
      expect(config.logoPath, 'path/to/logo');
    });

    // Add more tests for edge cases, like invalid color strings
  });
}
