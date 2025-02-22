import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/entities/balance.dart';

class BalanceModel extends Balance {
  BalanceModel({required super.balance});

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'balance': balance,
    };
  }

  BalanceModel copyWith({
    int? balance,
  }) {
    return BalanceModel(
      balance: balance ?? this.balance,
    );
  }
}
