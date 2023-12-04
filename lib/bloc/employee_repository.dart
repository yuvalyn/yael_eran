import 'package:hive/hive.dart';
import '../models/employee.dart';

class EmployeeRepository {
  static final EmployeeRepository _singleton = EmployeeRepository._internal();

  factory EmployeeRepository() {
    return _singleton;
  }

  EmployeeRepository._internal();

  Future<List<Employee>> addEmployee(Employee employee) async {
    var employeeBox = Hive.box<Employee>('employees');
    var keysBox = Hive.box<List<String>>('keys');

    var keysList = keysBox.get('keys_list', defaultValue: <String>[])!;
    keysList.insert(0, employee.id);
    await keysBox.put('keys_list', keysList);
    await employeeBox.put(employee.id, employee);

    return getSortedEmployees();
  }

  Future<List<Employee>> getSortedEmployees() async {
    var employeeBox = Hive.box<Employee>('employees');
    var keysBox = Hive.box<List<String>>('keys');
    var keysList = keysBox.get('keys_list', defaultValue: <String>[])!;

    return keysList.map((key) => employeeBox.get(key)).where((e) => e != null).cast<Employee>().toList();
  }

  Future<List<Employee>> deleteEmployee(String employeeId) async {
    var employeeBox = Hive.box<Employee>('employees');
    var keysBox = Hive.box<List<String>>('keys');

    await employeeBox.delete(employeeId);

    var keysList = keysBox.get('keys_list', defaultValue: <String>[])!;
    keysList.remove(employeeId);
    await keysBox.put('keys_list', keysList);

    return getSortedEmployees();
  }

  Future<List<Employee>> editEmployee(Employee updatedEmployee) async {
    var employeeBox = Hive.box<Employee>('employees');
    await employeeBox.put(updatedEmployee.id, updatedEmployee);

    return getSortedEmployees();
  }
}
