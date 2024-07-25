import 'package:flutter_expense_tracker_bloc/models/expense.dart';

enum Category {
  all,
  grocery,
  food,
  work,
  entertainment,
  traveling,
  other;

  String toJson() => name;
  static Category fromJson(String json) => values.byName(json);
}

extension CategoryX on Category {
  String get toName => switch (this) {
        Category.all => 'All',
        Category.entertainment => 'Entertainment',
        Category.food => 'Food',
        Category.grocery => 'Grocery',
        Category.work => 'Work',
        Category.traveling => 'Traveling',
        Category.other => 'Other',
      };

  bool apply(Expense? expense) => switch (this) {
        Category.all => true,
        Category.entertainment => expense?.category == Category.entertainment,
        Category.food => expense?.category == Category.food,
        Category.grocery => expense?.category == Category.grocery,
        Category.work => expense?.category == Category.work,
        Category.traveling => expense?.category == Category.traveling,
        Category.other => expense?.category == Category.other,
      };

  Iterable<Expense?> applyAll(Iterable<Expense?> expenses) {
    return expenses.where(apply);
  }
}
