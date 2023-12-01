import 'package:flutter/material.dart';
import 'package:graduate_app/theme/palette.dart';

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
          color: Palette.whiteColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(color: Palette.whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Palette.whiteColor),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      );
}
