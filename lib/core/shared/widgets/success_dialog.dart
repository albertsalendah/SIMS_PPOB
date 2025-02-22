import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';

class SuccesDialog extends StatelessWidget {
  final String nominal;
  final String text;
  final VoidCallback goBack;
  const SuccesDialog({
    super.key,
    required this.nominal,
    required this.text,
    required this.goBack,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppPallete.transparentColor,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: _sucess(context),
    );
  }

  Widget _sucess(BuildContext context) {
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
              CircleAvatar(
                radius: 45,
                backgroundColor: AppPallete.green,
                child: Icon(
                  Icons.check,
                  size: 32,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  text,
                  style: reguler14.copyWith(fontSize: 16),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Rp.${thousandSeparators(nominal)}',
                  style: bold16.copyWith(fontSize: 24),
                ),
              ),
              Text(
                'berhasil',
                style: reguler14.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  goBack();
                  Navigator.pop(context);
                },
                child: Text(
                  'Kembali ke Beranda',
                  style:
                      semibold14.copyWith(fontSize: 16, color: AppPallete.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
