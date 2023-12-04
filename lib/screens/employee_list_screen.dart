import 'package:employee_app/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_cubit.dart';
import '../bloc/employee_state.dart';
import '../l10n/app_localizations.dart';
import '../models/app_config.dart';
import '../widgets/floating_action_button_builder.dart';
import 'add_employee_screen.dart';
import 'edit_employee_screen.dart';

class EmployeeListScreen extends StatefulWidget {

  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen>
    with SingleTickerProviderStateMixin {
  List<Employee> employeeList = [];

  @override
  Widget build(BuildContext context) {
    final config =  AppConfig.instance;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(config.appName, style: TextStyle(color: config.tertiaryColor),),
            Spacer(),
            Image.asset(
              config.logoPath,
              width: 60,
              height: 60,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                // This code will execute if the image fails to load
                return const Icon(Icons.error);
              },
            )
          ],
        ),
      ),
      body: Builder(builder: (context) {
        return BlocListener<EmployeeCubit, EmployeeState>(
          listener: (context, state) {
            if (state is EmployeeListState) {
              setState(() {
                employeeList = state.employees;
              });
            }
          },
          child: Builder(builder: (context) {
            if (employeeList.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate('empty_state'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24,
                      color:  config.primaryColor),
                ),
              );
            }
            return ListView.builder(
              itemCount: employeeList.length,
              itemBuilder: (context, index) {
                final employee = employeeList[index];
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditEmployeeScreen(
                            employee,
                            (updateEmployee) => context
                                .read<EmployeeCubit>()
                                .editEmployee(updateEmployee))),
                  ),
                  title: Text(employee.name),
                  subtitle: Text(employee.position),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: config.secondaryColor,
                    onPressed: () => context
                        .read<EmployeeCubit>()
                        .deleteEmployee(employee.id),
                  ),
                );
              },
            );
          }),
        );
      }),
      floatingActionButton: AnimatedFloatingActionButton(
        showAnimation: employeeList.isEmpty,
        onAddPress: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddEmployeeScreen((employee) =>
                  context.read<EmployeeCubit>().addEmployee(employee))),
        ),
      ),
    );
  }
}
