// ignore_for_file: public_member_api_docs, sort_constructors_first
class Transaction {
  final String invc;
  final String? srvcCode;
  final String? srvcName;
  final String transactionType;
  final int amount;
  final String createAt;
  final String? description;

  Transaction({
    required this.invc,
    this.srvcCode,
    this.srvcName,
    required this.transactionType,
    required this.amount,
    required this.createAt,
    this.description,
  });
}
