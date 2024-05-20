import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/expense.dart';

class NewExpence extends StatefulWidget {
  const NewExpence({
    Key? key,
    required this.addNewExpense,
  }) : super(key: key);

  final Function(Expense newExpense) addNewExpense;
  @override
  State<NewExpence> createState() => _NewExpenceState();
}

class _NewExpenceState extends State<NewExpence> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

//انشات المتغير ده علي شان لما يكون عندي تاريخ عايز اعمل ليه فورمات
  final formatter = DateFormat.yMd();

  DateTime? DateSelected;
  Category selectCategory = Category.food;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //Title Field
              SingleChildScrollView(
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(label: Text("Title")),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Amount Field & Date Paker
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Amount"),
                          prefixText: "\$",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final now = DateTime.now();

                          final fristDate =
                              DateTime(now.year - 3, now.month, now.day);

                          final lastDate =
                              DateTime(now.year, now.month, now.day); // = now

                          final DateTime? datePaker = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: fristDate,
                            lastDate: lastDate,
                          );
                          setState(() {
                            DateSelected = datePaker;
                          });
                        },
                        child: ListTile(
                          trailing: const Icon(Icons.calendar_month_outlined),
                          title: Text(
                            DateSelected == null
                                ? "select date"
                                : formatter.format(DateSelected!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      DropdownButton(
                          value: selectCategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (newval) {
                            setState(() {
                              selectCategory = newval!;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final enterAmount =
                              double.tryParse(amountController.text);
                          final invaledAmount =
                              enterAmount == null || enterAmount <= 0;

                          if (invaledAmount ||
                              titleController.text.trim().isEmpty) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  titleTextStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                  content: const Text(
                                      "make sure you full all text fields"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        //هنا انا حطيت البراميتير الي اديته لداله البيلد علي شاان انا عايزه يقفل ال الاليرت ديالوج مش ال شو مودال بوتوم شيت لا ال كونتيكست الاساسيه هي بتاعت البيدج الي الي احنا فيها او بالاصح بتاعت ال بيلد فانكشن الاسايه خلص الي جوه ال استات
                                        Navigator.of(context).pop(ctx);
                                      },
                                      child: const Text('OK'),
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            widget.addNewExpense(Expense(
                              date: DateSelected ?? DateTime.now(),
                              title: titleController.text,
                              amount: enterAmount,
                              category: selectCategory,
                            ));
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Text(
                            "Save Title",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
