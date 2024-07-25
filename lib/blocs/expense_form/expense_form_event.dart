part of 'expense_form_bloc.dart';

sealed class ExpenseFormEvent extends Equatable {
  const ExpenseFormEvent();

  @override
  List<Object> get props => [];
}

final class ExpenseTitleChanged extends ExpenseFormEvent {
  const ExpenseTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class ExpenseAmountChanged extends ExpenseFormEvent {
  const ExpenseAmountChanged(this.amount);

  final String amount;

  @override
  List<Object> get props => [amount];
}

final class ExpenseDateChanged extends ExpenseFormEvent {
  const ExpenseDateChanged(this.date);

  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class ExpenseCategoryChanged extends ExpenseFormEvent {
  const ExpenseCategoryChanged(this.category);

  final Category category;

  @override
  List<Object> get props => [category];
}

final class ExpenseSubmitted extends ExpenseFormEvent {
  const ExpenseSubmitted();
}
