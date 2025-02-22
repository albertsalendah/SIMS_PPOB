import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

void showSnackBarError({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
          message,
          style: TextStyle(color: AppPallete.red1),
        ),
        showCloseIcon: true,
        closeIconColor: AppPallete.red1,
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.8,
        backgroundColor: AppPallete.red2,
      ),
    );
}

void showSnackBarSuccess({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(
          message,
          style: TextStyle(color: AppPallete.whiteColor),
        ),
        showCloseIcon: true,
        closeIconColor: AppPallete.whiteColor,
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.8,
        backgroundColor: AppPallete.green,
      ),
    );
}
