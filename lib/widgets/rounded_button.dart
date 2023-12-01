import 'package:flutter/material.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:graduate_app/utils/constants/measure.dart';
import 'package:graduate_app/utils/text_styles.dart';

class PrimaryRoundedButton extends StatelessWidget {
  const PrimaryRoundedButton({
    this.width,
    required this.text,
    required this.onTap,
    super.key,
  });

  final double? width;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Material(
        borderRadius: Measure.br_8,
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: onTap,
          borderRadius: Measure.br_8,
          // highlightColor: AppColors.secondaryPale,
          // splashColor: AppColors.secondaryPale,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: Measure.br_8,
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Palette.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Original secondary button.
class SecondaryRoundedButton extends StatelessWidget {
  const SecondaryRoundedButton({
    required this.text,
    required this.onTap,
    super.key,
  });

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Measure.br_8,
      color: Palette.whiteColor,
      child: InkWell(
        borderRadius: Measure.br_8,
        onTap: onTap,
        //highlightColor: AppColors.secondaryPale,
        //splashColor: AppColors.secondary.withOpacity(0.6),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: Measure.br_8,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyles.h3(color: Palette.appColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
