import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/employee.dart';
import 'employee_repository.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository _employeeRepository = EmployeeRepository();

  EmployeeCubit() : super(EmployeeListState(employees: [])){
    _init();
  }

  void _init() async {
    var employees = await _employeeRepository.getSortedEmployees();
    emit(EmployeeListState(employees: employees));
  }

  Future<void> addEmployee(Employee employee) async {
    final updatedEmployees = await _employeeRepository.addEmployee(employee);
    emit(EmployeeListState(employees: updatedEmployees));
  }

  Future<void> deleteEmployee(String employeeId) async {
    final updatedEmployees = await _employeeRepository.deleteEmployee(employeeId);
    emit(EmployeeListState(employees: updatedEmployees));
  }

  Future<void> editEmployee(Employee employee) async {
    final updatedEmployees = await _employeeRepository.editEmployee(employee);
    emit(EmployeeListState(employees: updatedEmployees));
  }
}
