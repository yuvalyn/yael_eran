import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/employee.dart';
import '../widgets/employee_form.dart';

class EditEmployeeScreen extends StatelessWidget {
  final Employee employee;
  final void Function(Employee) editEmployee;

  const EditEmployeeScreen( this.employee,  this.editEmployee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(AppLocalizations.of(context).translate('edit'))),
      body: Padding(
        padding:  const EdgeInsets.all(16.0),
        child: EmployeeForm(
          employee: employee,
          onSave: (updatedEmployee) {
            editEmployee(updatedEmployee);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
