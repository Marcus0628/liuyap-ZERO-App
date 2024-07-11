class Transaction {
  final String description;
  final double amount;
  final String date;
  final TransactionType type;

  Transaction({
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
  });
}

enum TransactionType {
  Payment,
  TopUp,
}