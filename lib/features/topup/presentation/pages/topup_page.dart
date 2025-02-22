import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/back_btn.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/red_button.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/saldo_card.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/success_failed_popups.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/show_snackbar.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/input_nominal.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/widgets/nominal_picker.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/confirm_dialog.dart';

class TopupPage extends StatefulWidget {
  final VoidCallback toHome;
  const TopupPage({super.key, required this.toHome});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  late TopupProvider _topupProvider;
  late AuthProvider _authProvider;
  String? token;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nominalController = TextEditingController();
  int max = 1000000;
  int min = 10000;

  @override
  void initState() {
    _authProvider = serviceLocator<AuthProvider>();
    _topupProvider = serviceLocator<TopupProvider>();
    token = _authProvider.getToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    _nominalController.dispose();
    super.dispose();
  }

  void _topup() async {
    String num = _nominalController.text.replaceAll(RegExp(r'\D'), '');
    if (_formKey.currentState!.validate()) {
      if (int.parse(num) > max) {
        _nominalController.text = max.toString();
        showSnackBarError(
            context: context,
            message:
                'Nominal tidak boleh lebih besar dari Rp.${thousandSeparators(max.toString())}');
      } else if (int.parse(num) < min) {
        _nominalController.text = min.toString();
        showSnackBarError(
            context: context,
            message:
                'Nominal tidak boleh lebih kecil dari Rp.${thousandSeparators(min.toString())}');
      } else {
        if (token != null) {
          showDialog(
            context: context,
            builder: (context) {
              return ConfirmDialog(
                isTopup: true,
                text: 'Anda yakin untuk Top Up sebesar',
                nominal: 'Rp.${thousandSeparators(num)}',
                confirm: () async {
                  await _topupProvider
                      .topupBalance(
                          nominal: int.parse(_nominalController.text
                              .replaceAll(RegExp(r'\D'), '')),
                          token: token!)
                      .then((v) {});
                },
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        popups(
          nominal: _nominalController.text,
          token: token,
          goBack: widget.toHome,
          onDissmis: () {
            if (mounted) {
              _nominalController.clear();
              setState(() {});
            }
          },
        ),
        BackBtn(label: AppStrings.topup, toHome: widget.toHome),
        SaldoCard(showHideBtn: false),
        const SizedBox(
          height: 50,
        ),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: '${AppStrings.topUp1}\n',
            style: reguler14.copyWith(fontSize: 18, color: AppPallete.black),
            children: [
              TextSpan(
                text: AppStrings.topUp2,
                style:
                    semibold14.copyWith(fontSize: 24, color: AppPallete.black),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Form(
          key: _formKey,
          child: InputNominal(
            hintText: AppStrings.topUpNominal,
            controller: _nominalController,
            prefixIcon: Icons.money_rounded,
            fun: (value) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        NominalPicker(
          function: (item) {
            setState(() {
              _nominalController.text = thousandSeparators(item.toString());
            });
          },
        ),
        const SizedBox(
          height: 30,
        ),
        RedButton(
            disable: _nominalController.text.isEmpty,
            text: 'Top Up',
            onPressed: () {
              _topup();
            }),
      ],
    );
  }
}
