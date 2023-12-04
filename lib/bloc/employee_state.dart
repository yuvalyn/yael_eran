import '../models/employee.dart';

abstract class EmployeeState{}

class InitialState extends EmployeeState{

}

class EmployeeListState extends EmployeeState{
  final List<Employee> employees;
  EmployeeListState({required this.employees});
}