import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/provider/transaction_provider.dart';

class ConfirmDialog extends StatelessWidget {
  final String nominal;
  final String text;
  final Future<void> Function() confirm;
  final bool isTopup;
  const ConfirmDialog(
      {super.key,
      required this.text,
      required this.nominal,
      required this.confirm,
      required this.isTopup});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppPallete.transparentColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Consumer2<TopupProvider, TransactionProvider>(
        builder: (context, topup, transaction, child) {
          return Visibility(
              visible: !(topup.status == TopUpStatus.loading ||
                  transaction.status == TransactionStatus.loading),
              replacement: Center(
                child: Loader(),
              ),
              child: _confirm(context));
        },
      ),
    );
  }

  Container _confirm(BuildContext context) {
    return Container(
      height: 350,
      width: 360,
      decoration: BoxDecoration(
          color: AppPallete.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/icons/Logo.png',
                scale: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                text,
                style: reguler14.copyWith(fontSize: 16),
              ),
              Text(
                '$nominal ?',
                style: semibold14.copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () async {
                  await confirm().then((v) {
                    if (context.mounted) {
                      Navigator.pop(context);
                    } else {
                      return;
                    }
                  });
                },
                child: Text(
                  'Ya, lanjutkan Top Up',
                  style:
                      semibold14.copyWith(fontSize: 16, color: AppPallete.red),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Batalkan',
                  style: semibold14.copyWith(
                      fontSize: 16, color: AppPallete.greyColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
