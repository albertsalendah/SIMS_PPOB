import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/routes/routes_name.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/di/init_dependencies.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/back_btn.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/confirm_dialog.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/red_button.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/saldo_card.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/success_failed_popups.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/show_snackbar.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/input_nominal.dart';
import 'package:sims_ppob_richard_albert_salendah/features/topup/presentation/provider/topup_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/transaction/presentation/provider/transaction_provider.dart';

class PaymentPage extends StatefulWidget {
  final Menus selectedService;
  const PaymentPage({
    super.key,
    required this.selectedService,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late AuthProvider _authProvider;
  late TransactionProvider _transactionProvider;
  String? token;
  final TextEditingController _trariffController = TextEditingController();
  bool cukup = false;
  int saldo = 0;
  int tariff = 0;

  @override
  void initState() {
    _trariffController.text =
        thousandSeparators(widget.selectedService.menuTariff.toString());
    tariff = int.parse(_trariffController.text.replaceAll(RegExp(r'\D'), ''));
    _authProvider = serviceLocator<AuthProvider>();
    _transactionProvider = serviceLocator<TransactionProvider>();
    token = _authProvider.getToken();
    saldo =
        Provider.of<TopupProvider>(context, listen: false).balance?.balance ??
            0;
    cukup = (saldo >= tariff);
    super.initState();
  }

  @override
  void dispose() {
    _trariffController.dispose();
    super.dispose();
  }

  void _bayar() {
    if (cukup) {
      if (token != null) {
        showDialog(
          context: context,
          builder: (context) {
            return ConfirmDialog(
              isTopup: false,
              text:
                  'Bayar ${widget.selectedService.menuName.toLowerCase()} prabayar senilai',
              nominal: 'Rp.${thousandSeparators(tariff.toString())}',
              confirm: () async {
                await _transactionProvider.servicePay(
                  srvcCode: widget.selectedService.menuCode,
                  token: token!,
                );
              },
            );
          },
        );
      }
    } else {
      showSnackBarError(
          context: context,
          message: 'Saldo anda tidak cukup, Silahkan Top Up!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BackBtn(
              label: AppStrings.bayar1,
              toHome: () {
                context.goNamed(RoutesName.navBar);
              }),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              popups(
                nominal: tariff.toString(),
                token: token,
                menu: widget.selectedService.menuName,
                goBack: () {
                  context.goNamed(RoutesName.navBar);
                },
                onDissmis: () {
                  if (context.mounted) {
                    saldo = Provider.of<TopupProvider>(context, listen: false)
                            .balance
                            ?.balance ??
                        0;
                    cukup = (saldo >= tariff);
                    setState(() {});
                  }
                },
              ),
              SaldoCard(
                showHideBtn: false,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                AppStrings.bayar1,
                style:
                    reguler14.copyWith(fontSize: 16, color: AppPallete.black),
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    child: Image.network(widget.selectedService.menuIcon),
                  ),
                  Text(
                    widget.selectedService.menuName,
                    style: semibold14.copyWith(
                        fontSize: 20, color: AppPallete.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              InputNominal(
                enable: false,
                hintText: AppStrings.topUpNominal,
                controller: _trariffController,
                prefixIcon: Icons.money_rounded,
                fun: (value) {},
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 200,
              ),
              RedButton(
                  disable: !cukup,
                  text: 'Bayar',
                  onPressed: () {
                    _bayar();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
