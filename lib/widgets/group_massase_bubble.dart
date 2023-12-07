import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graduate_app/models/group/group_model.dart';
import 'package:graduate_app/utils/extensions/date_time.dart';
import 'package:graduate_app/utils/firestore_refs/group_message_ref.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _senderIconSize = 24;

/// ふきだしのデザイン
class GroupMessageBubble extends ConsumerWidget {
  const GroupMessageBubble({
    required this.group,
    this.onTap,
    this.onLongPress,
    required this.isMyMessage,
    //required this.isGroupMessage,
    this.tail = true,
    required this.sizeSenderBubble,
    required this.message,
    required this.textStyle,
  });

  final GroupModel group;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  final bool isMyMessage;
  //final bool isGroupMessage;

  final bool tail;
  final EdgeInsetsGeometry sizeSenderBubble;

  final ReadGroupMessage message;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final partnerLastReadAt = ref.watch(groupPartnerLastReadAtProvider(group));

    return Column(
      crossAxisAlignment:
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isMyMessage)
          Text(
            message.senderId,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:
              isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMyMessage) ...[
              const Icon(
                Icons.account_circle,
                size: _senderIconSize * 2,
              ),
            ],
            GestureDetector(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Column(
                crossAxisAlignment: isMyMessage
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: CustomPaint(
                      painter: BubbleDesign(
                        color:
                            isMyMessage ? Colors.orange : Colors.grey.shade400,
                        alignment: isMyMessage
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        tail: tail,
                      ),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * .8,
                        ),
                        margin: isMyMessage
                            ? sizeSenderBubble
                            : EdgeInsets.fromLTRB(25, 15, 12.5, 15),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              child: message.messageType == MessageType.text
                                  ? Text(
                                      message.content,
                                      style: textStyle,
                                    )
                                  : Image.network(
                                      message.imageUrl,
                                      width: 250,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(2),
                  // _MessageCreatedAt(
                  //   groupMessage: message,
                  //   isMyMessage: isMyMessage,
                  // ),
                ],
              ),
            ),
          ],
        ),
        _MessageCreatedAt(
          groupMessage: message,
          isMyMessage: isMyMessage,
        ),
      ],
    );
  }
}

///custom painter use to create the shape of the chat bubble
///
/// [color],[alignment] and [tail] can be changed
class BubbleDesign extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  BubbleDesign({
    required this.color,
    required this.alignment,
    required this.tail,
  });

  final double _radius = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;

    if (alignment == Alignment.topRight) {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 2, 0);

        /// top-left corner
        path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

        /// left line
        path.lineTo(0, h - _radius * 1.5);

        /// bottom-left corner
        path.quadraticBezierTo(0, h, _radius * 2, h);

        /// bottom line
        path.lineTo(w - _radius * 3, h);

        /// bottom-right bubble curve
        path.quadraticBezierTo(
            w - _radius * 1.5, h, w - _radius * 1.5, h - _radius * 0.6);

        /// bottom-right tail curve 1
        path.quadraticBezierTo(w - _radius * 1, h, w, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            w - _radius * 0.8, h, w - _radius, h - _radius * 1.5);

        /// right line
        path.lineTo(w - _radius, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
      // else {
      //   var path = Path();

      //   /// starting point
      //   path.moveTo(_radius * 2, 0);

      //   /// top-left corner
      //   path.quadraticBezierTo(0, 0, 0, _radius * 1.5);

      //   /// left line
      //   path.lineTo(0, h - _radius * 1.5);

      //   /// bottom-left corner
      //   path.quadraticBezierTo(0, h, _radius * 2, h);

      //   /// bottom line
      //   path.lineTo(w - _radius * 3, h);

      //   /// bottom-right curve
      //   path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

      //   /// right line
      //   path.lineTo(w - _radius, _radius * 1.5);

      //   /// top-right curve
      //   path.quadraticBezierTo(w - _radius, 0, w - _radius * 3, 0);

      //   canvas.clipPath(path);
      //   canvas.drawRRect(
      //       RRect.fromLTRBR(0, 0, w, h, Radius.zero),
      //       Paint()
      //         ..color = color
      //         ..style = PaintingStyle.fill);
      // }
    } else {
      if (tail) {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);
        // bottom-right tail curve 1
        path.quadraticBezierTo(_radius * .8, h, 0, h);

        /// bottom-right tail curve 2
        path.quadraticBezierTo(
            _radius * 1, h, _radius * 1.5, h - _radius * 0.6);

        /// bottom-left bubble curve
        path.quadraticBezierTo(_radius * 1.5, h, _radius * 3, h);

        /// bottom line
        path.lineTo(w - _radius * 2, h);

        /// bottom-right curve
        path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

        /// right line
        path.lineTo(w, _radius * 1.5);

        /// top-right curve
        path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBR(0, 0, w, h, Radius.zero),
            Paint()
              ..color = color
              ..style = PaintingStyle.fill);
      }
      // else {
      //   var path = Path();

      //   /// starting point
      //   path.moveTo(_radius * 3, 0);

      //   /// top-left corner
      //   path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

      //   /// left line
      //   path.lineTo(_radius, h - _radius * 1.5);

      //   /// bottom-left curve
      //   path.quadraticBezierTo(_radius, h, _radius * 3, h);

      //   /// bottom line
      //   path.lineTo(w - _radius * 2, h);

      //   /// bottom-right curve
      //   path.quadraticBezierTo(w, h, w, h - _radius * 1.5);

      //   /// right line
      //   path.lineTo(w, _radius * 1.5);

      //   /// top-right curve
      //   path.quadraticBezierTo(w, 0, w - _radius * 2, 0);
      //   canvas.clipPath(path);
      //   canvas.drawRRect(
      //       RRect.fromLTRBR(0, 0, w, h, Radius.zero),
      //       Paint()
      //         ..color = color
      //         ..style = PaintingStyle.fill);
      // }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// class _ReadStatusText extends StatelessWidget {
//   const _ReadStatusText({
//     required this.messageCreatedAt,
//     required this.partnerLastReadAt,
//   });

//   final DateTime? messageCreatedAt;
//   final DateTime? partnerLastReadAt;

//   @override
//   Widget build(BuildContext context) {
//     final text = _readStatusString(
//       messageCreatedAt: messageCreatedAt,
//       partnerLastReadAt: partnerLastReadAt,
//     );
//     if (text.isEmpty) {
//       return const SizedBox();
//     }
//     return Padding(
//       padding: const EdgeInsets.only(top: 20),
//       child: Text(
//         text,
//         style: TextStyle(fontSize: 15, color: Colors.grey),
//       ),
//     );
//   }

//   String _readStatusString({
//     required DateTime? messageCreatedAt,
//     required DateTime? partnerLastReadAt,
//   }) {
//     if (messageCreatedAt == null) {
//       return '';
//     }
//     if (partnerLastReadAt == null) {
//       return '未読';
//     }
//     return messageCreatedAt.isAfter(partnerLastReadAt) ? '未読' : '既読';
//   }
// }

class _MessageCreatedAt extends StatelessWidget {
  const _MessageCreatedAt({
    required this.groupMessage,
    required this.isMyMessage,
  });

  final ReadGroupMessage groupMessage;
  final bool isMyMessage;

  @override
  Widget build(BuildContext context) {
    final createdAt = groupMessage.createdAt;
    if (createdAt == null) {
      return const SizedBox();
    }
    return Text(
      createdAt.formatRelativeDate(),
      style: TextStyle(
        color: Colors.grey,
        fontSize: 13.5,
      ),
    );
  }
}
