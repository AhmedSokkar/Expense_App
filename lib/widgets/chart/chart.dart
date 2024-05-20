import 'package:expenses_app/model/expense.dart';
import 'package:expenses_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expense});

  final List<Expense> expense;

  List<ExpenseBuket> bukets() {
    //بس كلهم هيكونوا نوع كاتيجوري واحدexpense objectيعتبر دي بترجع ليست ل ليست محتويتها هي ال
    //كده كاني بعمل ليست صغيره من الليست الكبيره
    return [
      ExpenseBuket.forCategory(
          items: expense,
          category: Category
              .food), //كده انت عملت ليست بكل الاوبجيكتز الي الكاتيجوري بتعها الاكل
      ExpenseBuket.forCategory(
          items: expense,
          category: Category
              .fun), //كده انت عملت ليست بكل الاوبجيكتز الي الكاتيجوري بتعها الترفيه
      ExpenseBuket.forCategory(
          items: expense,
          category: Category
              .travel), //كده انت عملت ليست بكل الاوبجيكتز الي الكاتيجوري بتعها السفر
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (var element in bukets()) {
      if (element.totalExpenses() > maxTotalExpense) {
        maxTotalExpense = element.totalExpenses();
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.9),
                Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final ele in bukets())
                      ChartBar(
                        fill: ele.totalExpenses() == 0
                            ? 0
                            : (ele.totalExpenses() / maxTotalExpense),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: bukets()
                    .map(
                      (e) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            categoryIcons[e.category],
                            color: Theme.of(context).listTileTheme.tileColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        );
      },
    );
  }
}
