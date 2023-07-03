import 'package:flutter/material.dart';
import 'package:graduate_app/models/models.dart';
import 'package:graduate_app/widget/myAlertDialog.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageBubble extends HookConsumerWidget {
  final bool isSender;
  final bool isEditor;
  final bool tail;
  final Color color;
  final TextStyle textStyle;
  final bool changeEnable;
  final void Function()? execution;

  final Message message;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isSender,
    required this.isEditor,
    this.color = Colors.orange,
    this.tail = true,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    required this.changeEnable,
    required this.execution,
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: isSender
          ? () {
              isEditor
                  ? null
                  : showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return MyAlertDialog(
                          title: "メッセージを送信しますか？",
                          txt_cancel: "キャンセル",
                          txt_ok: "送信",
                          txt_snack: "メッセージを送信しました",
                          exe: () {},
                        );
                      },
                    );
            }
          : null,
      onLongPress: isEditor
          ? () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: 140,
                      //color: Colors.amber,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.edit,
                              size: 30,
                            ),
                            title: Text(
                              "編集",
                              style: TextStyle(fontSize: 28),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.delete,
                              size: 30,
                            ),
                            title: Text(
                              "削除",
                              style: TextStyle(fontSize: 28),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return MyAlertDialog(
                                    title: "メッセージを削除しますか？",
                                    txt_cancel: "キャンセル",
                                    txt_ok: "削除",
                                    txt_snack: "メッセージを削除しました",
                                    exe: execution,
                                  );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    );
                  });
            }
          : null,
      child: Align(
        alignment: isSender ? Alignment.topRight : Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          child: CustomPaint(
            painter: BubbleSampleDesign(
              color: color,
              alignment: isSender ? Alignment.topRight : Alignment.topLeft,
              tail: tail,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .8,
              ),
              margin: isSender
                  ? EdgeInsets.fromLTRB(20, 15, 25, 15)
                  : EdgeInsets.fromLTRB(25, 15, 20, 15),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: changeEnable
                        ? TextField(
                            enabled: changeEnable,
                            style: textStyle,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          )
                        : Text(
                            message.messageText,
                            style: textStyle,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///custom painter use to create the shape of the chat bubble
///
/// [color],[alignment] and [tail] can be changed
class BubbleSampleDesign extends CustomPainter {
  final Color color;
  final Alignment alignment;
  final bool tail;

  BubbleSampleDesign({
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
      } else {
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

        /// bottom-right curve
        path.quadraticBezierTo(w - _radius, h, w - _radius, h - _radius * 1.5);

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
      } else {
        var path = Path();

        /// starting point
        path.moveTo(_radius * 3, 0);

        /// top-left corner
        path.quadraticBezierTo(_radius, 0, _radius, _radius * 1.5);

        /// left line
        path.lineTo(_radius, h - _radius * 1.5);

        /// bottom-left curve
        path.quadraticBezierTo(_radius, h, _radius * 3, h);

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
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
