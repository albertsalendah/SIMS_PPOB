import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/history.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/usecases/get_transaction.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/usecases/service_payment.dart';

enum TransactionStatus {
  initial,
  loading,
  paymentSuccess,
  getSuccess,
  error,
  paymentError
}

class TransactionProvider with ChangeNotifier {
  final ServicePayment servicePayment;
  final GetTransaction getTransaction;

  TransactionProvider({
    required this.servicePayment,
    required this.getTransaction,
  });

  TransactionStatus _status = TransactionStatus.initial;
  String? _message;
  Transaction? _transaction;
  History? _history;

  TransactionStatus get status => _status;
  String? get message => _message;
  Transaction? get transaction => _transaction;
  History? get history => _history;

  Future<void> getTransactions(
      {required int offset, required int limit, required String token}) async {
    _setStatus(TransactionStatus.loading);
    final result = await getTransaction(HistoryParam(
      offset: offset,
      limit: limit,
      token: token,
    ));
    result.fold((failure) {
      _setStatus(TransactionStatus.error, message: failure.message);
    }, (success) {
      _history = success.data;
      _setStatus(TransactionStatus.getSuccess, message: success.message);
    });
  }

  Future<void> servicePay(
      {required String srvcCode, required String token}) async {
    _setStatus(TransactionStatus.loading);
    final result = await servicePayment(
        ServicePaymentParams(srvcCode: srvcCode, token: token));
    result.fold((failure) {
      _setStatus(TransactionStatus.paymentError, message: failure.message);
    }, (success) {
      _transaction = success.data;
      _setStatus(TransactionStatus.paymentSuccess, message: success.message);
    });
  }

  void _setStatus(TransactionStatus status, {String? message}) {
    _status = status;
    _message = message;
    notifyListeners();
  }

  void resetState() {
    _setStatus(TransactionStatus.initial);
  }
}
