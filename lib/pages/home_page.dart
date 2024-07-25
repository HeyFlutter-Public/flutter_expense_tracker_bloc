import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_bloc/extensions/extensions.dart';

import '../widgets/expense_filter_widget.dart';
import '../widgets/expenses_widget.dart';
import '../widgets/total_expenses_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello, Good Morning')),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TotalExpensesWidget(),
            SizedBox(height: 14),
            ExpenseFilterWidget(),
            SizedBox(height: 14),
            ExpensesWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.showAddExpenseSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
