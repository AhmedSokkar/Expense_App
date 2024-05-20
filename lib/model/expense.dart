//we do this class for identefy the most properties in expense in App
//adn put it in Model Folder to make this class unique and we will use it much ok

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, fun, travel }

final datetime = DateFormat.yMd();

const categoryIcons = {
  Category.food: Icons.fastfood_outlined,
  Category.fun: Icons.movie_creation_outlined,
  Category.travel: Icons.travel_explore,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String FormatDate() {
    return datetime.format(date);
  }

  Expense(
      {required this.date,
      required this.title,
      required this.amount,
      required this.category})
      : id = uuid.v4();
}

//هنا هيدخل ليست من الاوبجيكت بالنسبه لل كاتيجوري بنعها
class ExpenseBuket {
  ExpenseBuket({required this.category, required this.itemsOfCategory});

  ExpenseBuket.forCategory(
      {required List<Expense> items, required this.category})
      : itemsOfCategory =
            items.where((element) => element.category == category).toList();

  final Category category;
  //expenses
  final List<Expense> itemsOfCategory;

  double totalExpenses() {
    double sum = 0;

    for (var expense in itemsOfCategory) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
