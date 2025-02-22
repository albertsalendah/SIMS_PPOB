import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class InputField extends StatelessWidget {
  final bool? enable;
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  const InputField(
      {super.key,
      this.enable,
      required this.hintText,
      required this.controller,
      required this.prefixIcon,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: reguler14.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enable,
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
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppPallete.borderColor, width: 2),
              )),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
        ),
      ],
    );
  }
}
