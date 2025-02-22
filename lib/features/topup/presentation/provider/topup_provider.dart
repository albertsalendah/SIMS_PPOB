import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/entities/balance.dart';

import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/usecases/get_balance.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/domain/usecases/topup_balance.dart';

enum TopUpStatus {
  initial,
  loading,
  successBalance,
  successTopup,
  error,
  topupError
}

class TopupProvider with ChangeNotifier {
  final GetBalance getBalances;
  final TopupBalance topupBalances;
  TopupProvider({
    required this.getBalances,
    required this.topupBalances,
  });

  TopUpStatus _status = TopUpStatus.initial;
  String? _message;
  Balance? _balance;

  TopUpStatus get status => _status;
  String? get message => _message;
  Balance? get balance => _balance;

  Future<void> getBalance({required String token}) async {
    _setStatus(TopUpStatus.loading);
    final result = await getBalances(token);
    result.fold((failure) {
      _setStatus(TopUpStatus.error, message: failure.message);
    }, (success) {
      _balance = success.data;
      _setStatus(TopUpStatus.successBalance, message: success.message);
    });
  }

  Future<void> topupBalance(
      {required int nominal, required String token}) async {
    _setStatus(TopUpStatus.loading);
    final result =
        await topupBalances(TopupBalanceParam(nominal: nominal, token: token));
    result.fold((failure) {
      _setStatus(TopUpStatus.topupError, message: failure.message);
    }, (success) {
      _setStatus(TopUpStatus.successTopup, message: success.message);
    });
  }

  void _setStatus(TopUpStatus status, {String? message}) {
    _status = status;
    _message = message;
    notifyListeners();
  }

  void resetState() {
    _setStatus(TopUpStatus.initial);
  }
}
