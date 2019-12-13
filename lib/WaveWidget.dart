import 'package:flutter/material.dart';

///创建时间：2019/12/12 15:09
///作者：杨淋
///描述：搜索波浪

class WaveWidget extends StatefulWidget {
  double beginRadius;
  double endRadius;
  Color color;
  int count;
  PaintingStyle paintingStyle;
  Duration duration;

  WaveWidget({
    this.beginRadius,
    this.endRadius,
    this.color,
    this.duration,
    this.count,
    this.paintingStyle,
  });

  @override
  _WaveWidgetState createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
    final Animation<double> curve =
        new CurvedAnimation(parent: controller, curve: Curves.linear);
    animation =
        new Tween<double>(begin: widget.beginRadius, end: widget.endRadius)
            .animate(curve);
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: widget.endRadius * 2,
      height: widget.endRadius * 2,
      child: CustomPaint(
          painter: WavePainter(
            color: widget.color,
            radius: animation.value,
            offset: widget.endRadius,
            opacity: 1 - controller.value,
            minRadius: widget.beginRadius,
            maxRadius: widget.endRadius,
            paintingStyle: widget.paintingStyle,
            count: widget.count,
            context: context,
          ),
          child: RepaintBoundary(
//              child:
              child: Icon(
            Icons.bluetooth,
            color: Colors.white,
            size: widget.beginRadius,
          ))),
    ));
  }
}

class WavePainter extends CustomPainter {
  double minRadius;
  double maxRadius;
  double radius;
  Color color;
  double offset;
  double opacity;
  PaintingStyle paintingStyle;
  BuildContext context;
  int count;

  WavePainter(
      {this.color,
      this.radius,
      this.offset,
      this.opacity,
      this.minRadius,
      this.maxRadius,
      this.paintingStyle,
      this.context,
      this.count});

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..style = paintingStyle
      ..color = color.withOpacity(opacity);
    double xOffset = context.size.width / 2;

    canvas.drawCircle(Offset(xOffset, offset), radius, wavePaint);

    double length = (maxRadius + minRadius) / count;
    for (int i = 1; i < count; i++) {
      double startLength = length * i;

      if (radius > startLength) {
        wavePaint
          ..color = color.withOpacity((opacity + 1.0 / count * i) > 1
              ? 1
              : (opacity + 1.0 / count * i));
        canvas.drawCircle(Offset(xOffset, offset),
            radius - startLength + minRadius, wavePaint);
      } else {
        wavePaint
          ..color = color.withOpacity((opacity + 1.0 / count * i - 1) < 0
              ? 0
              : (opacity + 1.0 / count * i - 1));
        canvas.drawCircle(Offset(xOffset, offset),
            radius + maxRadius - startLength, wavePaint);
      }
    }

    wavePaint..color = Colors.blue;
    canvas.drawCircle(Offset(xOffset, offset), minRadius, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
