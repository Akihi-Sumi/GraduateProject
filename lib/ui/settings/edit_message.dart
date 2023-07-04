import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/features/features.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/ui/settings/create_message_page.dart';
import 'package:graduate_app/widget/message_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class EditMessagePage extends HookConsumerWidget {
  const EditMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bool tfEnable = false;
    // bool modeChange = true;

    final messages = ref.watch(messagesProvider).maybeWhen<List<Message>>(
          data: (data) {
            return data.sublist(0, data.length >= 20 ? 20 : data.length);
          },
          orElse: () => [],
        );

    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: messages
                  .map(
                    (message) => MessageBubble(
                      message: message,
                      isSender: true,
                      isEditer: true,
                      changeEnable: false,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              _sliderAnimationBuilder(
                widget: CreateMessagePage(),
              ),
            );
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_comment_rounded,
            color: Colors.orange[700],
            size: 40,
          ),
        ),
      ),
    );
  }
}

PageRouteBuilder _sliderAnimationBuilder({required Widget widget}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 200),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    fullscreenDialog: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      // 表示する画面のWidget
      return widget;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1); // 下から上
      // final Offset begin = Offset(0.0, -1.0); // 上から下
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
