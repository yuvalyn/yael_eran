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

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(config.appName, style: TextStyle(color: config.tertiaryColor)),
            Spacer(),
            Image.asset(
              config.logoPath,
              width: 60,
              height: 60,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Icon(Icons.error); // Image load failure
              },
            )
          ],
        ),
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadingState) {
            return const Center(child:CircularProgressIndicator());
          }
          if (state is EmployeeListState) {
            if (state.employees.isNotEmpty) {
              return ListView.builder(
                itemCount: state.employees.length,
                itemBuilder: (context, index) {
                  final employee = state.employees[index];
                  return ListTile(
                    onTap: () =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditEmployeeScreen(
                                  employee,
                                      (updateEmployee) =>
                                      context.read<EmployeeCubit>()
                                          .editEmployee(updateEmployee),
                                ),
                          ),
                        ),
                    title: Text(employee.name),
                    subtitle: Text(employee.position),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: config.secondaryColor,
                      onPressed: () =>
                          context.read<EmployeeCubit>()
                              .deleteEmployee(employee.id),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  AppLocalizations.of(context).translate('empty_state'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: config.primaryColor),
                ),
              );
            }
          } else{
            return const Center(
              child: Text('Unhandled state'),
            );
          }
          // This closing brace was missing
        },
      ),
      floatingActionButton: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          return AnimatedFloatingActionButton(
            showAnimation: state is EmployeeListState && state.employees.isEmpty,
            onAddPress: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEmployeeScreen(
                      (employee) => context.read<EmployeeCubit>().addEmployee(employee),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
