import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignedOut extends StatelessWidget {
  const SignedOut({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('機能を使用するには、サインインが必要です。'),
          Text('下記のいずれかの方法でサインインしてください。'),
          Gap(24),
        ],
      ),
    );
  }
}
