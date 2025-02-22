import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class BackBtn extends StatelessWidget {
  final String label;
  final VoidCallback toHome;
  const BackBtn({
    super.key,
    required this.label,
    required this.toHome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                toHome();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    color: AppPallete.black,
                  ),
                  const SizedBox(width: 4),
                  Text('Kembali', style: semibold14.copyWith(fontSize: 16)),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Center(
                  child:
                      Text(label, style: semibold14.copyWith(fontSize: 16)))),
          Flexible(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
