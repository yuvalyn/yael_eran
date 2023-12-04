import 'package:employee_app/bloc/employee_cubit.dart';
import 'package:employee_app/bloc/employee_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockEmployeeCubit extends MockCubit<EmployeeState>
    implements EmployeeCubit {}
