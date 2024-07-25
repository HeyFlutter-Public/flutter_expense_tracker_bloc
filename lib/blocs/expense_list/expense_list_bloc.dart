import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_expense_tracker_bloc/models/category.dart';
import 'package:flutter_expense_tracker_bloc/models/expense.dart';
import 'package:flutter_expense_tracker_bloc/repositories/expense_repository.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  ExpenseListBloc({
    required ExpenseRepository repository,
  })  : _repository = repository,
        super(const ExpenseListState()) {
    on<ExpenseListSubscriptionRequested>(_onSubscriptionRequested);
    on<ExpenseListExpenseDeleted>(_onExpenseDeleted);
    on<ExpenseListCategoryFilterChanged>(_onExpenseCategoryFilterChanged);
  }

  final ExpenseRepository _repository;

  Future<void> _onSubscriptionRequested(
    ExpenseListSubscriptionRequested event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(status: () => ExpenseListStatus.loading));

    final stream = _repository.getAllExpenses();

    await emit.forEach<List<Expense?>>(
      stream,
      onData: (expenses) => state.copyWith(
        status: () => ExpenseListStatus.success,
        expenses: () => expenses,
        totalExpenses: () => expenses
            .map((currentExpense) => currentExpense?.amount)
            .fold(0.0, (a, b) => a + b!),
      ),
      onError: (_, __) => state.copyWith(
        status: () => ExpenseListStatus.failure,
      ),
    );
  }

  Future<void> _onExpenseDeleted(
    ExpenseListExpenseDeleted event,
    Emitter<ExpenseListState> emit,
  ) async {
    await _repository.deleteExpense(event.expense.id);
  }

  Future<void> _onExpenseCategoryFilterChanged(
    ExpenseListCategoryFilterChanged event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }
}
