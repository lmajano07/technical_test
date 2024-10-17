enum TransactionType {
  expense,
  income;

  @override
  String toString() {
    switch (this) {
      case == expense:
        return 'expense';
      case == income:
        return 'income';
      default:
        return 'expense';
    }
  }
}

TransactionType transactionTypeFromString(String type) {
  switch (type) {
    case 'expense':
      return TransactionType.expense;
    case 'income':
      return TransactionType.income;
    default:
      return TransactionType.expense;
  }
}
