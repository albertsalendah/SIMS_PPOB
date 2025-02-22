import 'package:flutter/material.dart';
import 'app_pallet.dart';

class AppTheme {
  //Example theme
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: color, width: 2),
      );

  static final themeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.whiteColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      hintStyle: TextStyle(
        color: AppPallete.greyColor,
      ),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(),
      errorBorder: _border(AppPallete.errorColor),
      // disabledBorder: _border(),
      prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.error)) {
          return AppPallete.errorColor;
        }
        return AppPallete.black;
      }),
      suffixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.error)) {
          return AppPallete.errorColor;
        }
        return AppPallete.black;
      }),
    ),
  );
}
