import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expense_tracker_bloc/blocs/expense_list/expense_list_bloc.dart';
import 'package:flutter_expense_tracker_bloc/models/category.dart';

class ExpenseFilterWidget extends StatelessWidget {
  const ExpenseFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = Category.values;

    final activeFiler = context.select(
      (ExpenseListBloc bloc) => bloc.state.filter,
    );

    return LimitedBox(
      maxHeight: 40,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];

          return ChoiceChip(
            label: Text(category.toName),
            selected: activeFiler == category,
            onSelected: (_) => context
                .read<ExpenseListBloc>()
                .add(ExpenseListCategoryFilterChanged(category)),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: Category.values.length,
      ),
    );
  }
}
