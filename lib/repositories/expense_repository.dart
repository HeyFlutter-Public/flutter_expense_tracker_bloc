import 'package:flutter_expense_tracker_bloc/data/local_data_storage.dart';
import 'package:flutter_expense_tracker_bloc/models/expense.dart';

class ExpenseRepository {
  final LocalDataStorage _storage;

  const ExpenseRepository({
    required LocalDataStorage storage,
  }) : _storage = storage;

  Future<void> createExpense(Expense expense) => _storage.saveExpense(expense);

  Future<void> deleteExpense(String id) => _storage.deleteExpense(id);

  Stream<List<Expense?>> getAllExpenses() => _storage.getExpenses();
}
