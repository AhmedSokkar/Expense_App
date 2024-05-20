import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/expense_list/expense_list.dart';
import 'package:expenses_app/widgets/expense_list/new_expence.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> items = [
    Expense(
      date: DateTime.now(),
      title: "pizza",
      amount: 642,
      category: Category.food,
    ),
    Expense(
      date: DateTime.now(),
      title: "sharm",
      amount: 1000,
      category: Category.travel,
    ),
    Expense(
      date: DateTime.now(),
      title: "Mariegn film",
      amount: 200,
      category: Category.fun,
    ),
  ];

  void addExpense(Expense newExpense) {
    setState(() {
      items.add(newExpense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      items.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var mobileWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                //isScrollControlled: true,
                //useSafeArea: true,
                context: context,
                builder: (c) => NewExpence(addNewExpense: addExpense),
              );
            },
            icon: const Icon(
              Icons.add_comment,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      body: mobileWidth < 700
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chart(expense: items),
                Expanded(
                  child:
                      ExpenseList(items: items, removeExpense: removeExpense),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //هنا حطينا لل شارت اكسبانديد علي شان ال شارت انا مديها العرض ب انفنيتي و ده بوظ الدنيا
                Expanded(child: Chart(expense: items)),
                Expanded(
                  child:
                      ExpenseList(items: items, removeExpense: removeExpense),
                )
              ],
            ),
    );
  }
}
