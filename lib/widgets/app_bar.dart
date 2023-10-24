import 'package:flutter/material.dart';
import 'package:graduate_app/utils/constants/app_colors.dart';
import 'package:graduate_app/utils/text_styles.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.elevation = 1,
    this.actions,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final Widget? leading;
  final double elevation;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading,
      centerTitle: true,
      elevation: elevation,
      title: Text(
        title,
        style: TextStyles.h2(),
      ),
      backgroundColor: AppColors.baseBlack,
      iconTheme: const IconThemeData(color: AppColors.baseWhite),
      actions: actions,
    );
  }
}
