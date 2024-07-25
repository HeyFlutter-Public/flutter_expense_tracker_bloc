part of 'expense_list_bloc.dart';

enum ExpenseListStatus { initial, loading, success, failure }

final class ExpenseListState extends Equatable {
  const ExpenseListState({
    this.expenses = const [],
    this.status = ExpenseListStatus.initial,
    this.totalExpenses = 0.0,
    this.filter = Category.all,
  });

  final List<Expense?> expenses;
  final ExpenseListStatus status;
  final double totalExpenses;
  final Category filter;

  Iterable<Expense?> get filteredExpenses => filter.applyAll(expenses);

  ExpenseListState copyWith({
    List<Expense?> Function()? expenses,
    ExpenseListStatus Function()? status,
    double Function()? totalExpenses,
    Category Function()? filter,
  }) {
    return ExpenseListState(
      expenses: expenses != null ? expenses() : this.expenses,
      status: status != null ? status() : this.status,
      totalExpenses:
          totalExpenses != null ? totalExpenses() : this.totalExpenses,
      filter: filter != null ? filter() : this.filter,
    );
  }

  factory ExpenseListState.initial() {
    return const ExpenseListState();
  }

  @override
  List<Object?> get props => [expenses, status, totalExpenses, filter];
}
