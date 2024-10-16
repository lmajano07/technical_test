import 'package:flutter/material.dart';

const List<Color> colorList = [
  Colors.green,
  Colors.blueGrey,
  Colors.teal,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkmode = false,
  })  : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
          ),
        ),
      );

  AppTheme copyWith({int? selectedColor, bool? isDarkmode}) => AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkmode: isDarkmode ?? this.isDarkmode,
      );
}
