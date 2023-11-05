import 'package:flutter/material.dart';

class Unavailable extends StatelessWidget {
  const Unavailable(
    this.object, {
    this.includesAppBar = false,
    super.key,
  });

  final Object? object;

  /// [Scaffold] および [AppBar] を含めるかどうか。
  final bool includesAppBar;

  @override
  Widget build(BuildContext context) {
    if (includesAppBar) {
      return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text(
              object == null ? '問題が発生しました。' : object.toString(),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            object == null ? '問題が発生しました。' : object.toString(),
          ),
        ),
      );
    }
  }
}
