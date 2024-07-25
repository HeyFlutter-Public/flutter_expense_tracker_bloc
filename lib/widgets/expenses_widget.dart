import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker_bloc/blocs/expense_list/expense_list_bloc.dart';

import 'expense_tile_widget.dart';
import 'loading_widget.dart';

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListBloc, ExpenseListState>(
      builder: (context, state) {
        if (state.status == ExpenseListStatus.loading) {
          return const LoadingWidget(radius: 12, addPadding: true);
        }

        final expenses = state.filteredExpenses.toList();

        if (state.status == ExpenseListStatus.success && expenses.isEmpty) {
          return const EmptyListWidget();
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: expenses.length,
          itemBuilder: (context, index) => ExpenseTileWidget(
            expense: expenses[index]!,
          ),
        );
      },
    );
  }
}

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        children: [
          const Icon(Icons.search),
          const SizedBox(height: 10),
          Text(
            'Nothing see here',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
