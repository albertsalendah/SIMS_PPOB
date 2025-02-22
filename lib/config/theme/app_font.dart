import 'package:flutter/material.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';

TextStyle reguler12_5 = const TextStyle(
    fontFamily: 'SF-Pro-Display', fontSize: 12.5, color: AppPallete.black);
TextStyle reguler14 = reguler12_5.copyWith(fontSize: 14);

TextStyle semibold12_5 = reguler12_5.copyWith(fontWeight: FontWeight.w600);
TextStyle semibold14 = semibold12_5.copyWith(fontSize: 14, letterSpacing: 0.1);

TextStyle bold16 = reguler12_5.copyWith(
    fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.1);
TextStyle bold18 = bold16.copyWith(fontSize: 18, letterSpacing: -0.5);
