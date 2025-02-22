import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class RedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disable;
  const RedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.disable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppPallete.red,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ElevatedButton(
        onPressed: !disable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppPallete.greyColor,
          fixedSize: const Size(double.infinity, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppPallete.whiteColor),
        ),
      ),
    );
  }
}
