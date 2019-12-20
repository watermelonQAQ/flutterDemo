import 'package:flutter/material.dart';

///创建时间：2019/12/12 15:09
///作者：杨淋
///描述：搜索波浪

class WaveWidget extends StatefulWidget {
  final double beginRadius;
  final double endRadius;
  final Color color;
  final int count;
  final PaintingStyle paintingStyle;
  final Duration duration;
  final Widget child;
  final bool withAlpha;
  final bool haveBackground;

  WaveWidget({
    this.beginRadius = 0,
    @required this.endRadius,
    this.color = Colors.blue,
    this.duration = const Duration(seconds: 1),
    this.count = 1,
    this.paintingStyle = PaintingStyle.fill,
    this.child,
    this.withAlpha = true,
    this.haveBackground = true,
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
            withAlpha: widget.withAlpha,
            haveBackground:widget.haveBackground,
            context: context,
          ),
          child: RepaintBoundary(
//              child:
              child:widget.child)),
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
  bool withAlpha;
  bool haveBackground;

  WavePainter(
      {this.color,
      this.radius,
      this.offset,
      this.opacity,
      this.minRadius,
      this.maxRadius,
      this.paintingStyle,
      this.context,
        this.withAlpha,
        this.haveBackground,
      this.count});

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..style = paintingStyle
      ..color = color.withOpacity(opacity);
    double xOffset = context.size.width / 2;

    canvas.drawCircle(Offset(xOffset, offset), radius, wavePaint);


    double length = (maxRadius - minRadius) / count;
    for (int i = 1; i < count; i++) {
      double startLength = length * i;

      if ((radius-minRadius) > startLength) {
        wavePaint
          ..color = color.withOpacity((opacity + 1.0 / count * i) > 1
              ? 1
              : (opacity + 1.0 / count * i));
        canvas.drawCircle(Offset(xOffset, offset),
            radius - startLength , wavePaint);
      } else {
        wavePaint
          ..color = color.withOpacity((opacity + 1.0 / count * i - 1) < 0
              ? 0
              : (opacity + 1.0 / count * i - 1));
        canvas.drawCircle(Offset(xOffset, offset),
            radius + maxRadius - startLength -minRadius, wavePaint);
      }
    }

    if(haveBackground){
      wavePaint..color = color.withOpacity(1);
      canvas.drawCircle(Offset(xOffset, offset), minRadius, wavePaint);
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
