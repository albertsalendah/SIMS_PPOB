import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

class InputNominal extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final Function(String value) fun;
  final bool enable;
  const InputNominal(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.prefixIcon,
      required this.fun,
      this.enable = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        fun(value);
      },
      enabled: enable,
      style: TextStyle(color: AppPallete.black),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+(\.[0-9]{0,2})?$')),
      ],
      decoration: InputDecoration(
        hintText: hintText,
        errorStyle: TextStyle(
          fontSize: 14,
          color: AppPallete.errorColor,
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppPallete.borderColor),
            borderRadius: BorderRadius.circular(4)),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            prefixIcon,
            color: AppPallete.greyColor,
          ),
        ),
      ),
    );
  }
}
