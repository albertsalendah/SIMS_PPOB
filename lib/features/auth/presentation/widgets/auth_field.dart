import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconButton? suffixIcon;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    required this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        obscuringCharacter: '●',
        style: TextStyle(color: AppPallete.black),
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: TextStyle(
            fontSize: 14,
            color: AppPallete.errorColor,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(prefixIcon),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: suffixIcon,
          ),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
      ),
    );
  }
}
