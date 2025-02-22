// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';

class History {
  final int offset;
  final int limit;
  final List<Transaction>? records;

  History({
    required this.offset,
    required this.limit,
    required this.records,
  });
}
