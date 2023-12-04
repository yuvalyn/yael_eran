import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../l10n/app_localizations.dart';
import '../models/employee.dart';
import '../widgets/employee_form.dart';

class AddEmployeeScreen extends StatelessWidget {
  void Function(Employee) addEmployee;

  AddEmployeeScreen(this.addEmployee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(AppLocalizations.of(context).translate('add'))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: EmployeeForm(
          onSave: (employee) {
            addEmployee(Employee(
              id: const Uuid().v4(), // Generating a unique ID
              name: employee.name,
              position: employee.position,
            ));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
