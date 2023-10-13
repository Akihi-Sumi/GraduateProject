import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/features/message.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/widgets/message_bubble.dart';
import 'package:graduate_app/widgets/send_location.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeScreenPage extends HookConsumerWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messagesProvider).maybeWhen<List<Message>>(
          data: (data) {
            return data.sublist(0, data.length >= 20 ? 20 : data.length);
          },
          orElse: () => [],
        );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 110),
          child: Column(
            children: messages
                .map(
                  (message) => Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: MessageBubble(
                      message: message,
                      isSender: true,
                      isEditor: false,
                      changeEnable: false,
                      execution: () {},
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: SendLocation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
