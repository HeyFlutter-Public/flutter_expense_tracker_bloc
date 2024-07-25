import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_expense_tracker_bloc/models/category.dart';
import 'package:flutter_expense_tracker_bloc/models/expense.dart';
import 'package:flutter_expense_tracker_bloc/repositories/expense_repository.dart';
import 'package:uuid/uuid.dart';

part 'expense_form_event.dart';
part 'expense_form_state.dart';

class ExpenseFormBloc extends Bloc<ExpenseFormEvent, ExpenseFormState> {
  ExpenseFormBloc({
    required ExpenseRepository repository,
    Expense? initialExpense,
  })  : _repository = repository,
        super(ExpenseFormState(
          initialExpense: initialExpense,
          title: initialExpense?.title,
          amount: initialExpense?.amount,
          date: initialExpense?.date ?? DateTime.now(),
          category: initialExpense?.category ?? Category.other,
        )) {
    on<ExpenseTitleChanged>(_onTitleChanged);
    on<ExpenseAmountChanged>(_onAmountChanged);
    on<ExpenseDateChanged>(_onDateChanged);
    on<ExpenseCategoryChanged>(_onCategoryChanged);
    on<ExpenseSubmitted>(_onSubmitted);
  }

  final ExpenseRepository _repository;

  void _onTitleChanged(
    ExpenseTitleChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onAmountChanged(
    ExpenseAmountChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    final amount = double.parse(event.amount);
    emit(state.copyWith(amount: amount));
  }

  void _onDateChanged(
    ExpenseDateChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(date: event.date));
  }

  void _onCategoryChanged(
    ExpenseCategoryChanged event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _onSubmitted(
    ExpenseSubmitted event,
    Emitter<ExpenseFormState> emit,
  ) async {
    final expense = (state.initialExpense)?.copyWith(
          title: state.title,
          amount: state.amount,
          date: state.date,
          category: state.category,
        ) ??
        Expense(
          id: const Uuid().v4(),
          title: state.title!,
          amount: state.amount!,
          date: state.date,
          category: state.category,
        );

    emit(state.copyWith(status: ExpenseFormStatus.loading));

    try {
      await _repository.createExpense(expense);
      emit(state.copyWith(status: ExpenseFormStatus.success));
      emit(ExpenseFormState(date: DateTime.now()));
    } catch (e) {
      emit(state.copyWith(status: ExpenseFormStatus.failure));
    }
  }
}
