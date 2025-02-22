import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/failed_dialog.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/success_dialog.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/provider/transaction_provider.dart';

Consumer2<TopupProvider, TransactionProvider> popups(
    {required String? token,
    required String nominal,
    String menu = '',
    required VoidCallback onDissmis,
    required VoidCallback goBack}) {
  String text1 = 'Pembayaran $menu prabayar sebesar';
  String text2 = 'Top Up sebesar';
  return Consumer2<TopupProvider, TransactionProvider>(
      builder: (context, topup, transaction, child) {
    // log('TopUp : ${topup.status} Transaction : ${transaction.status}');
    if (transaction.status == TransactionStatus.paymentSuccess ||
        topup.status == TopUpStatus.successTopup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return SuccesDialog(
              text: menu.isNotEmpty ? text1 : text2,
              nominal: thousandSeparators(nominal),
              goBack: () {
                goBack();
              },
            );
          },
        ).then((v) async {
          transaction.resetState();
          topup.resetState();
          if (token != null) {
            await serviceLocator<TopupProvider>().getBalance(token: token);
          }
          onDissmis();
        });
      });
    } else if (transaction.status == TransactionStatus.paymentError ||
        topup.status == TopUpStatus.topupError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (context) {
            return FailedDialog(
              text: menu.isNotEmpty ? text1 : text2,
              nominal: thousandSeparators(nominal),
              goBack: () {
                goBack();
              },
            );
          },
        ).then((v) async {
          transaction.resetState();
          topup.resetState();
          if (token != null) {
            await serviceLocator<TopupProvider>().getBalance(token: token);
          }
          onDissmis();
        });
      });
    }
    return const SizedBox.shrink();
  });
}
