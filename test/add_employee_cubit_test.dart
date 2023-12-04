import 'package:flutter_test/flutter_test.dart';
import 'package:employee_app/models/employee.dart';
import 'package:employee_app/bloc/employee_state.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_cubit.dart';

class FallbackEmployee extends Fake implements Employee {}

void main() {
  late MockEmployeeCubit mockCubit;

  setUp(() {
    mockCubit = MockEmployeeCubit();
    registerFallbackValue(FallbackEmployee());
    // Set up the initial state
    when(() => mockCubit.state).thenReturn(EmployeeListState(employees: []));
  });

  test('Add Employee to Cubit', () async {
    // Create a mock cubit
    final mockCubit = MockEmployeeCubit();

    // New employee to be added
    final newEmployee =
        Employee(id: '2', name: 'Jane Doe', position: 'Designer');

    // Set up the initial state
    when(() => mockCubit.state).thenReturn(EmployeeListState(employees: []));

    // Simulate the state change when an employee is added
    when(() => mockCubit.addEmployee(any())).thenAnswer((_) async {
      // Emit new state with the added employee
      final updatedEmployees = [newEmployee];
      when(() => mockCubit.state)
          .thenReturn(EmployeeListState(employees: updatedEmployees));
    });

    // Trigger the add employee action
    mockCubit.addEmployee(newEmployee);

    // Verify the new employee is added to the cubit's state
    final currentState = mockCubit.state;
    expect(currentState, isA<EmployeeListState>());
    expect(
        (currentState as EmployeeListState).employees, contains(newEmployee));
  });
}
