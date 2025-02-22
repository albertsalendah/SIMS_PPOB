import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';

class SaldoCard extends StatefulWidget {
  final bool showHideBtn;
  const SaldoCard({
    super.key,
    required this.showHideBtn,
  });

  @override
  State<SaldoCard> createState() => _SaldoCardState();
}

class _SaldoCardState extends State<SaldoCard> {
  bool _visible = false;
  int saldo = 0;
  // String hideSaldo = '$saldo'.replaceAll(RegExp(r"."), "●");
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/Background Saldo.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.usaldo,
            style: reguler14.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppPallete.whiteColor),
          ),
          const SizedBox(
            height: 14,
          ),
          Consumer<TopupProvider>(builder: (context, provider, _) {
            if (provider.status == TopUpStatus.successBalance) {
              saldo = provider.balance?.balance ?? 0;
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final padRight = MediaQuery.of(context).padding.right;
                return SizedBox(
                  width: constraints.maxWidth - padRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Rp ',
                            style: bold18.copyWith(
                                fontSize: 36, color: AppPallete.whiteColor)),
                        Visibility(
                          visible: !(provider.status == TopUpStatus.loading),
                          replacement: SizedBox(
                            width: constraints.maxWidth / 1.2,
                            child: const LinearProgressIndicator(
                              backgroundColor: AppPallete.whiteColor,
                            ),
                          ),
                          child: Text(
                            widget.showHideBtn
                                ? _visible
                                    ? thousandSeparators('$saldo')
                                    : "●●●●●●●●●"
                                : thousandSeparators('$saldo'),
                            style: semibold14.copyWith(
                                fontSize: widget.showHideBtn
                                    ? _visible
                                        ? 36
                                        : 20
                                    : 36,
                                letterSpacing: widget.showHideBtn
                                    ? _visible
                                        ? 1
                                        : 6
                                    : 1,
                                color: AppPallete.whiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          const SizedBox(
            height: 16,
          ),
          Visibility(
            visible: widget.showHideBtn,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      AppStrings.usaldo,
                      style: reguler14.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppPallete.whiteColor),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(!_visible ? Icons.visibility : Icons.visibility_off),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
