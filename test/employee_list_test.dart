import 'package:employee_app/models/app_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee_app/screens/employee_list_screen.dart';
import 'package:employee_app/models/employee.dart';
import 'package:employee_app/bloc/employee_cubit.dart';
import 'package:employee_app/bloc/employee_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockEmployeeCubit extends MockCubit<EmployeeState> implements EmployeeCubit {}

void main() {
  group('EmployeeListScreen Tests', () {
    late MockEmployeeCubit mockCubit;

    setUp(() {
      AppConfig(
        appName: 'Test App',
        primaryColor: Colors.blue,
        secondaryColor: Colors.green,
        tertiaryColor: Colors.yellow,
        logoPath: 'path/to/logo',
      );
      mockCubit = MockEmployeeCubit();

      whenListen(
        mockCubit,
        Stream.fromIterable([
          EmployeeListState(employees: [
            Employee(id: '1', name: 'John Doe', position: 'Developer'),
            Employee(id: '2', name: 'Jane Doe', position: 'Designer'),
          ]),
        ]),
        initialState: EmployeeListState(employees: []), // Initial state
      );
    });

    testWidgets('should display a list of employees when state is EmployeeListState', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeCubit>(
            create: (context) => mockCubit,
            child: EmployeeListScreen(),
          ),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<EmployeeCubit>(
            create: (context) => mockCubit,
            child: const EmployeeListScreen(),
          ),
        ),
      );

      // Verify that the list of employees is displayed
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('Developer'), findsOneWidget);
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('Designer'), findsOneWidget);
    });
  });
}
