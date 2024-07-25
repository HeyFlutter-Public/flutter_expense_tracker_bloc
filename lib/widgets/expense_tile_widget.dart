import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker_bloc/blocs/expense_list/expense_list_bloc.dart';
import 'package:flutter_expense_tracker_bloc/extensions/extensions.dart';
import 'package:flutter_expense_tracker_bloc/models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseTileWidget extends StatelessWidget {
  const ExpenseTileWidget({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final formattedDate = DateFormat('dd/MM/yyyy').format(expense.date);

    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final price = currency.format(expense.amount);

    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(16),
        color: colorScheme.error,
        child: Icon(Icons.delete, color: colorScheme.onError),
      ),
      onDismissed: (direction) {
        context
            .read<ExpenseListBloc>()
            .add(ExpenseListExpenseDeleted(expense: expense));
      },
      child: ListTile(
        onTap: () => context.showAddExpenseSheet(expense: expense),
        leading: Icon(Icons.car_repair, color: colorScheme.surfaceTint),
        title: Text(expense.title, style: textTheme.titleMedium),
        subtitle: Text(
          formattedDate,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onBackground.withOpacity(0.5),
          ),
        ),
        trailing: Text('-$price', style: textTheme.titleLarge),
      ),
    );
  }
}
