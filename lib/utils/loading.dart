import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:graduate_app/theme/palette.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//import 'constants/app_colors.dart';

/// アプリ全体に半透明のローディング画面を重ねるかどうか。
/// Whether to stack semi-transparent background
final overlayLoadingProvider = StateProvider<bool>((_) => false);

/// show a primary color's SpinkitCircle.
class PrimarySpinkitCircle extends StatelessWidget {
  const PrimarySpinkitCircle({
    super.key,
    this.size = 48,
  });

  final double size;
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: size,
      color: Palette.appColor,
    );
  }
}

/// This [Widget] prevent app users to double tap.
class OverlayLoadingWidget extends StatelessWidget {
  const OverlayLoadingWidget({
    super.key,
    this.backgroundColor = Colors.orange,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor.withOpacity(0.7),
      child: const SizedBox.expand(
        child: Center(
          child: PrimarySpinkitCircle(),
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
