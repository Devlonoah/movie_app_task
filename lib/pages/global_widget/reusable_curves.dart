import 'package:flutter/material.dart';
import '../../theme/color.dart';

class ReusableBottomCurves extends StatelessWidget {
  const ReusableBottomCurves({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            painter: BottomCurve1(),
            child: Container(
              height: height * 0.1,
            ),
          ),
          CustomPaint(
            painter: BottomCurve2(),
            child: Container(
              height: height * 0.1,
            ),
          )
        ],
      ),
    );
  }
}

class BottomCurve1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = AppColor.curveOneColor;
    path = Path();
    path.lineTo(0, size.height * 0.4);
    path.cubicTo(0, size.height * 0.4, size.width * 0.03, size.height * 0.48,
        size.width * 0.03, size.height * 0.48);
    path.cubicTo(size.width * 0.07, size.height * 0.56, size.width * 0.13,
        size.height * 0.72, size.width / 5, size.height * 0.68);
    path.cubicTo(size.width * 0.27, size.height * 0.64, size.width / 3,
        size.height * 0.4, size.width * 0.4, size.height * 0.24);
    path.cubicTo(size.width * 0.47, size.height * 0.08, size.width * 0.53, 0,
        size.width * 0.6, 0);
    path.cubicTo(size.width * 0.67, 0, size.width * 0.73, size.height * 0.08,
        size.width * 0.8, size.height * 0.22);
    path.cubicTo(size.width * 0.87, size.height * 0.36, size.width * 0.93,
        size.height * 0.56, size.width * 0.97, size.height * 0.66);
    path.cubicTo(size.width * 0.97, size.height * 0.66, size.width,
        size.height * 0.76, size.width, size.height * 0.76);
    path.cubicTo(size.width, size.height * 0.76, size.width, size.height,
        size.width, size.height);
    path.cubicTo(size.width, size.height, size.width * 0.97, size.height,
        size.width * 0.97, size.height);
    path.cubicTo(size.width * 0.93, size.height, size.width * 0.87, size.height,
        size.width * 0.8, size.height);
    path.cubicTo(size.width * 0.73, size.height, size.width * 0.67, size.height,
        size.width * 0.6, size.height);
    path.cubicTo(size.width * 0.53, size.height, size.width * 0.47, size.height,
        size.width * 0.4, size.height);
    path.cubicTo(size.width / 3, size.height, size.width * 0.27, size.height,
        size.width / 5, size.height);
    path.cubicTo(size.width * 0.13, size.height, size.width * 0.07, size.height,
        size.width * 0.03, size.height);
    path.cubicTo(
        size.width * 0.03, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height * 0.4, 0, size.height * 0.4);
    path.cubicTo(
        0, size.height * 0.4, 0, size.height * 0.4, 0, size.height * 0.4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BottomCurve2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = AppColor.curveTwoColor;
    path = Path();
    path.lineTo(0, 0);
    path.cubicTo(0, 0, size.width * 0.04, size.height * 0.04, size.width * 0.04,
        size.height * 0.04);
    path.cubicTo(size.width * 0.08, size.height * 0.08, size.width * 0.17,
        size.height * 0.15, size.width / 4, size.height * 0.28);
    path.cubicTo(size.width / 3, size.height * 0.41, size.width * 0.42,
        size.height * 0.59, size.width / 2, size.height * 0.63);
    path.cubicTo(size.width * 0.58, size.height * 0.67, size.width * 0.67,
        size.height * 0.55, size.width * 0.75, size.height * 0.52);
    path.cubicTo(size.width * 0.83, size.height * 0.48, size.width * 0.92,
        size.height * 0.52, size.width * 0.96, size.height * 0.54);
    path.cubicTo(size.width * 0.96, size.height * 0.54, size.width,
        size.height * 0.55, size.width, size.height * 0.55);
    path.cubicTo(size.width, size.height * 0.55, size.width, size.height,
        size.width, size.height);
    path.cubicTo(size.width, size.height, size.width * 0.96, size.height,
        size.width * 0.96, size.height);
    path.cubicTo(size.width * 0.92, size.height, size.width * 0.83, size.height,
        size.width * 0.75, size.height);
    path.cubicTo(size.width * 0.67, size.height, size.width * 0.58, size.height,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.42, size.height, size.width / 3, size.height,
        size.width / 4, size.height);
    path.cubicTo(size.width * 0.17, size.height, size.width * 0.08, size.height,
        size.width * 0.04, size.height);
    path.cubicTo(
        size.width * 0.04, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, 0, 0, 0);
    path.cubicTo(0, 0, 0, 0, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
