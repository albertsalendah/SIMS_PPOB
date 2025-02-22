import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppPallete.red,
      ),
    );
  }
}
