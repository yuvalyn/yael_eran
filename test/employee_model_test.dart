import 'package:employee_app/models/employee.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Employee Model Tests', () {
    test('Should create an Employee object with given values', () {
      final employee = Employee(id: '1', name: 'John Doe', position: 'Developer');

      expect(employee.id, '1');
      expect(employee.name, 'John Doe');
      expect(employee.position, 'Developer');
    });
  });
}
