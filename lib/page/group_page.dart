import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduate_app/controller/group_message.dart';
import 'package:graduate_app/models/message/message.dart';
import 'package:graduate_app/page/group/send_message_page.dart';
import 'package:graduate_app/widgets/message_bubble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class GroupRouterPage extends AutoRouter {
  const GroupRouterPage({super.key});
}

@RoutePage()
class GroupPage extends HookConsumerWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupMessages =
        ref.watch(groupMessageProvider).maybeWhen<List<Message>>(
              data: (data) => data.toList(),
              orElse: () => [],
            );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: groupMessages
                .map(
                  (messages) => Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: MessageBubble(
                      message: messages,
                      isSender: false,
                      isEditor: false,
                      changeEnable: false,
                      sendToGroup: () {},
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        padding: EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.orange[700],
          heroTag: "post",
          onPressed: () => showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (builder) {
              return SelectPostTypeSheet();
            },
            backgroundColor: Colors.grey[850],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
          ),
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class SelectPostTypeSheet extends StatelessWidget {
  const SelectPostTypeSheet({Key? key}) : super(key: key);

  void navigateToType(BuildContext context, String type) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SendMessagePage(type: type)));
  }

  @override
  Widget build(BuildContext context) {
    double cardHeightWidth = kIsWeb ? 360 : 120;
    double iconSize = kIsWeb ? 120 : 60;

    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.add_comment,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // メッセージ作成画面orウィジェット
              navigateToType(context, 'text');
            },
          ),
          GestureDetector(
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // 画像選択画面orウィジェット
            },
          ),
          GestureDetector(
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.black,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // カメラ起動
            },
          ),
        ],
      ),
    );
  }
}
