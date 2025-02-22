import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.invc,
    super.srvcCode,
    super.srvcName,
    required super.transactionType,
    required super.amount,
    required super.createAt,
    super.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      invc: json['invoice_number'],
      srvcCode: json['service_code'],
      srvcName: json['service_name'],
      transactionType: json['transaction_type'],
      amount: json['total_amount'],
      createAt: json['created_on'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'invoice_number': invc,
      'service_code': srvcCode,
      'service_name': srvcName,
      'transaction_type': transactionType,
      'total_amount': amount,
      'created_on': createAt,
      'description': description,
    };
  }

  TransactionModel copyWith({
    String? invc,
    String? srvcCode,
    String? srvcName,
    String? transactionType,
    int? amount,
    String? createAt,
    String? description,
  }) {
    return TransactionModel(
      invc: invc ?? this.invc,
      srvcCode: srvcCode ?? this.srvcCode,
      srvcName: srvcName ?? this.srvcName,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      createAt: createAt ?? this.createAt,
      description: description ?? this.description,
    );
  }
}
