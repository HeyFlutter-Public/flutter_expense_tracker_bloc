import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker_bloc/blocs/expense_form/expense_form_bloc.dart';
import 'package:flutter_expense_tracker_bloc/models/expense.dart';
import 'package:flutter_expense_tracker_bloc/repositories/expense_repository.dart';
import 'package:flutter_expense_tracker_bloc/widgets/add_expense_sheet_widget.dart';

extension AppX on BuildContext {
  Future<void> showAddExpenseSheet({Expense? expense}) {
    return showModalBottomSheet(
      context: this,
      builder: (context) => BlocProvider(
        create: (context) => ExpenseFormBloc(
          initialExpense: expense,
          repository: read<ExpenseRepository>(),
        ),
        child: const AddExpenseSheetWidget(),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
    );
  }
}
