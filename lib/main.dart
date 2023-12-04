import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_theme.dart';
import 'bloc/employee_cubit.dart';
import 'l10n/app_localizations_delegate.dart';
import 'models/employee.dart';
import 'screens/employee_list_screen.dart';
import 'models/app_config.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  await Hive.openBox<Employee>('employees');
  await Hive.openBox<List<String>>('keys');

  await AppConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(),
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
        ],
        title: 'Employee App',
        theme: AppTheme.theme,
        home: const EmployeeListScreen(),
      ),
    );
  }
}
