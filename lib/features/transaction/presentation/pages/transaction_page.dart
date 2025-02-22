import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/back_btn.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/saldo_card.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/domain/entities/transaction.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/provider/transaction_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/widgets/history_card.dart';

class TransactionPage extends StatefulWidget {
  final VoidCallback toHome;
  const TransactionPage({super.key, required this.toHome});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int oldOffset = 0;
  int newOffset = 0;
  int limit = 5;
  String token = '';

  @override
  void initState() {
    token = serviceLocator<AuthProvider>().getToken() ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await serviceLocator<TransactionProvider>()
          .getTransactions(token: token, offset: 0, limit: 5);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Transaction> list = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackBtn(label: AppStrings.transaksi, toHome: widget.toHome),
        SaldoCard(showHideBtn: false),
        const SizedBox(
          height: 30,
        ),
        Text(
          AppStrings.transaksi,
          style: semibold14.copyWith(fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            oldOffset = ((provider.history?.offset ?? 0) +
                (provider.history?.limit ?? 0));
            list = provider.history?.records ?? [];
            return SizedBox(
              height: 400,
              child: Visibility(
                visible: !(provider.status == TransactionStatus.loading),
                replacement: const Center(
                  child: Loader(),
                ),
                child: Visibility(
                  visible: list.isNotEmpty,
                  replacement: Center(
                    child: Text(AppStrings.emptyList),
                  ),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return HistoryCard(
                        transaction: list[index],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: TextButton(
              onPressed: () async {
                newOffset =
                    (list.isNotEmpty) ? (newOffset + oldOffset) : oldOffset;
                await serviceLocator<TransactionProvider>().getTransactions(
                    token: token, offset: newOffset, limit: limit);
              },
              child: Text(
                'Show more',
                style: semibold14.copyWith(color: AppPallete.red),
              )),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
