import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker_bloc/blocs/expense_list/expense_list_bloc.dart';
import 'package:flutter_expense_tracker_bloc/repositories/expense_repository.dart';

import 'pages/home_page.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key, required this.expenseRepository});

  final ExpenseRepository expenseRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: expenseRepository,
      child: BlocProvider(
        create: (context) => ExpenseListBloc(
          repository: expenseRepository,
        )..add(const ExpenseListSubscriptionRequested()),
        child: MaterialApp(
          home: const HomePage(),
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
