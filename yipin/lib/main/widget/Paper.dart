
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:base/extension/ListExt.dart';
import 'package:base/extension/WidgetExt.dart';

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint( // 使用CustomPaint
        painter: PaperPainter(),
    ));
  }
}

class PaperPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    // final Paint paint = Paint();
    // // 绘制圆
    // canvas.drawCircle(Offset(10, 10), 10, paint);
    // canvas.drawLine(Offset(50, 10), Offset(50, 50), paint
    //   ..color = Colors.red
    //     ..strokeWidth = 4
    //     ..style = PaintingStyle.fill
    // );

    // final Paint newPaint = Paint();
    // Path path = Path();
    // path.moveTo(100, 100);
    // path.lineTo(200, 0);
    // canvas.drawPath(path, newPaint..color = Colors.red);

    drawStyleStrokeWidth(canvas);
    // drawStrokeCap(canvas);
    drawStrokeJoin(canvas);
  }

  //只有画笔是 stroke 类型线宽才会起作用。 而且线条的宽度有一半在外侧，必要时需要进行校正
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint =  Paint()..color=Colors.red;
    canvas.drawCircle(
        Offset(35, 35),
        30,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth =10);
    canvas.drawCircle(
        Offset(30 + 90.0, 30),
        30,
        paint
          ..strokeWidth = 10
          ..style = PaintingStyle.fill);
  }

  void drawStrokeCap(Canvas canvas) {
    Paint paint =  Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(
        Offset(50, 50), Offset(50, 150), paint..strokeCap = StrokeCap.butt);
    canvas.drawLine(Offset(50 + 50.0, 50), Offset(50 + 50.0, 150),
        paint..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(50 + 50.0 * 2, 50), Offset(50 + 50.0 * 2, 150),
        paint..strokeCap = StrokeCap.square);
  }

  // StrokeJoin.bevel - 斜角、
  // StrokeJoin.miter - 锐角、
  // StrokeJoin.round - 圆角
  void drawStrokeJoin(Canvas canvas) {
    Paint paint =  Paint();
    Path path =  Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 10;
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(50, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(50 + 150.0, 50);
    path.lineTo(50 + 150.0, 150);
    path.relativeLineTo(50, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(50 + 150.0 * 2, 50);
    path.lineTo(50 + 150.0 * 2, 150);
    path.relativeLineTo(50, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

