import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/format_tanggal.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';

class HistoryCard extends StatelessWidget {
  final Transaction transaction;
  const HistoryCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    bool isTopup = transaction.transactionType == 'TOPUP' ? true : false;
    String textAmount = isTopup
        ? "+ Rp.${thousandSeparators(transaction.amount.toString())}"
        : "- Rp.${thousandSeparators(transaction.amount.toString())}";

    return Card(
      elevation: 1,
      color: AppPallete.whiteColor,
      margin: EdgeInsets.fromLTRB(8, 8, 8, 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    textAmount,
                    style: bold18.copyWith(
                        fontSize: 20,
                        color:
                            isTopup ? AppPallete.green : AppPallete.errorColor),
                  ),
                ),
                Text(
                  transaction.description ?? '',
                  style: semibold12_5,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              formatTanggal(transaction.createAt),
              style: reguler12_5.copyWith(color: AppPallete.greyColor),
            ),
          ],
        ),
      ),
    );
  }
}
