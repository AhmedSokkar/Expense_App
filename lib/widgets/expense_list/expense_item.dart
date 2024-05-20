import 'package:flutter/material.dart';
import 'package:expenses_app/model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.index, required this.items});

  final int index;

  final List<Expense> items;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        items[index].title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
      leading: Text(
        "\$${items[index].amount.toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 15),
      ),
      trailing: Icon(categoryIcons[items[index].category]),
      subtitle: Text(
        items[index].FormatDate(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
