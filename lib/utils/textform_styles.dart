import 'package:flutter/material.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';

/// [TextFormField] arguments, i.e., the form styles of [InputDecoration].
class AppTextFormStyles {
  AppTextFormStyles();

  static InputDecoration onGeneral({
    required IconData iconData,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          iconData,
        ),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: AppColors.secondaryPale,
        //     width: 2,
        //   ),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: color,
        //   ),
        // ),
      );

  static InputDecoration onPassword({
    required ValueNotifier<bool> isObscure,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(
          Icons.lock,
        ),
        suffixIcon: isObscure.value
            ? IconButton(
                icon: Icon(
                  Icons.visibility_off,
                  color: Colors.grey.shade400,
                ),
                onPressed: () {
                  isObscure.value = false;
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.visibility,
                  color: Colors.grey.shade400,
                ),
                onPressed: () {
                  isObscure.value = true;
                },
              ),
      );

  static InputDecoration onResetPassword({
    required IconData iconData,
  }) =>
      InputDecoration(
        contentPadding: EdgeInsets.zero,
        prefixIcon: Icon(
          iconData,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryPale,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.secondaryPale,
          ),
        ),
      );
}
