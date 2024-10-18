class Balance {
  final double expense;
  final double income;

  Balance({
    required this.expense,
    required this.income,
  });

  factory Balance.empty() => Balance(expense: 0.0, income: 0.0);

  double get balance => income - expense;
}
