import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/thousand_separator.dart';

class NominalPicker extends StatelessWidget {
  final Function(int) function;
  const NominalPicker({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    final List<int> listNominal = [
      10000,
      20000,
      50000,
      100000,
      250000,
      500000,
    ];
    return SizedBox(
      height: 165,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.2,
        ),
        itemCount: listNominal.length,
        itemBuilder: (BuildContext context, int index) {
          final item = listNominal[index];
          return GestureDetector(
            onTap: () {
              function(item);
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppPallete.greyColor),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  'Rp.${thousandSeparators('$item')}',
                  style: semibold14.copyWith(color: AppPallete.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
