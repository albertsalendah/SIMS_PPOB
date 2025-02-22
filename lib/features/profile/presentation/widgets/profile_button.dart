import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class ProfileButton extends StatelessWidget {
  final bool switcher;
  final String text;
  final VoidCallback onPressed;
  const ProfileButton({
    super.key,
    required this.switcher,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: switcher ? AppPallete.red : AppPallete.whiteColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(double.infinity, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(color: AppPallete.red)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: switcher ? AppPallete.whiteColor : AppPallete.red),
        ),
      ),
    );
  }
}
