import 'package:expenses_app/widgets/expenses_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final colorscheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 103, 80, 164),
  );

  final colorschemeDark = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 59, 96, 176),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: colorscheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorscheme.primary,
          foregroundColor: colorscheme.onPrimary,
        ),
        listTileTheme: const ListTileThemeData().copyWith(
          selectedTileColor: colorscheme.primaryContainer,
          iconColor: colorscheme.onPrimaryContainer,
          textColor: colorscheme.onPrimaryContainer,
          tileColor: colorscheme.primaryContainer,
        ),
      ),
      //Dark Mode
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: colorschemeDark,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: colorschemeDark.onSecondaryContainer),
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorschemeDark.primary,
          foregroundColor: colorschemeDark.onPrimary,
        ),
        listTileTheme: const ListTileThemeData().copyWith(
          selectedTileColor: colorschemeDark.primaryContainer,
          iconColor: colorschemeDark.onPrimaryContainer,
          textColor: colorschemeDark.onPrimaryContainer,
          tileColor: colorschemeDark.primaryContainer,
        ),
      ),
      home: const Expenses(),
    );
  }
}
