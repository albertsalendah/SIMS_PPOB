import 'package:sims_ppob_richard_albert_salendah/features/transaction/data/models/transaction_model.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/history.dart';

class HistoryModel extends History {
  HistoryModel({
    required super.offset,
    required super.limit,
    super.records,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    List<TransactionModel> transactionList = [];
    if (json['records'] != null) {
      transactionList = (json['records'] as List<dynamic>).map((item) {
        TransactionModel transaction = TransactionModel.fromJson(item);
        return transaction;
      }).toList();
    }
    return HistoryModel(
      offset: int.tryParse(json['offset']?.toString() ?? '') ?? 0,
      limit: int.tryParse(json['limit']?.toString() ?? '') ?? 0,
      records: transactionList,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'offset': offset,
      'limit': limit,
      'records': records,
    };
  }

  HistoryModel copyWith({
    int? offset,
    int? limit,
    List<TransactionModel>? records,
  }) {
    return HistoryModel(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      records: records ?? this.records,
    );
  }
}
