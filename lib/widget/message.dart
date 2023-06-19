import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final bool isSender;
  final String text;
  final bool tail;
  final Color color;
  final TextStyle textStyle;

  const Message({
    Key? key,
    required this.isSender,
    required this.text,
    this.color = Colors.orange,
    this.tail = true,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSender
          ? () {
              print("タップで動きを実装する");
            }
          : null,
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: CustomPaint(
            painter: BubbleSampleDesign(
              color: color,
              alignment: Alignment.topLeft,
              tail: tail,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .8,
              ),
              margin: const EdgeInsets.fromLTRB(17, 7, 7, 7),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Text(
                      text,
                      style: textStyle,
                      textAlign: TextAlign.left,
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
      path.quadraticBezierTo(_radius * 1, h, _radius * 1.5, h - _radius * 0.6);

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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
