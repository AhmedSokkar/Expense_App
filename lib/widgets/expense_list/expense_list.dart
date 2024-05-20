import 'package:expenses_app/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.items,
    required this.removeExpense,
  });

  final List<Expense> items;
  final Function(Expense newExpense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Dismissible(
              key: ValueKey(items[index]),
              onDismissed: (direction) => removeExpense(items[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error,
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete_forever_rounded),
                      Icon(Icons.delete_forever_rounded),
                    ],
                  ),
                ),
              ),
              child: ExpenseItem(
                index: index,
                items: items,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
