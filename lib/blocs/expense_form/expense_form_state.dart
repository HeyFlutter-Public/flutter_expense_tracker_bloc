part of 'expense_form_bloc.dart';

enum ExpenseFormStatus { initial, loading, success, failure }

extension ExpenseFormStatusX on ExpenseFormStatus {
  bool get isLoading => [
        ExpenseFormStatus.loading,
        ExpenseFormStatus.success,
      ].contains(this);
}

final class ExpenseFormState extends Equatable {
  const ExpenseFormState({
    this.title,
    this.amount,
    required this.date,
    this.category = Category.other,
    this.status = ExpenseFormStatus.initial,
    this.initialExpense,
  });

  final String? title;
  final double? amount;
  final DateTime date;
  final Category category;
  final ExpenseFormStatus status;
  final Expense? initialExpense;

  ExpenseFormState copyWith({
    String? title,
    double? amount,
    DateTime? date,
    Category? category,
    ExpenseFormStatus? status,
    Expense? initialExpense,
  }) {
    return ExpenseFormState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      status: status ?? this.status,
      initialExpense: initialExpense ?? this.initialExpense,
    );
  }

  @override
  List<Object?> get props => [
        title,
        amount,
        date,
        category,
        status,
        initialExpense,
      ];

  bool get isFormValid => title != null && amount != null;
}
