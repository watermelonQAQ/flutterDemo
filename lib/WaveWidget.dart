import 'package:flutter/material.dart';

///创建时间：2019/12/12 15:09
///作者：杨淋
///描述：搜索波浪

class WaveWidget extends StatefulWidget {
  double beginRadius;
  double endRadius;
  Color color;
  Duration duration;

  WaveWidget({
    this.beginRadius,
    this.endRadius,
    this.color,
    this.duration,
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
            context: context,
          ),
          child: RepaintBoundary(
//              child:
              child:   Icon(
                Icons.bluetooth,
                color: Colors.white,
                size: widget.beginRadius,
              )
          )),
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
  Paint wavePaint = Paint();
  BuildContext context;

  WavePainter(
      {this.color, this.radius, this.offset, this.opacity, this.minRadius,this.maxRadius,this.context});

  @override
  void paint(Canvas canvas, Size size) {

    wavePaint
      ..style = PaintingStyle.fill
      ..color = color.withOpacity(opacity);
//    double xOffset = MediaQuery.of(context).size.width;
    double xOffset = context.size.width/2;

    canvas.drawCircle(Offset(xOffset, offset), radius, wavePaint);

    if(radius > (maxRadius + minRadius )/2){
      wavePaint
        ..color = color.withOpacity(opacity + 0.5);
      canvas.drawCircle(Offset(xOffset, offset), radius-(maxRadius + minRadius) /2 + minRadius, wavePaint);

    }else{
      wavePaint
        ..color = color.withOpacity(opacity - 0.5);
      canvas.drawCircle(Offset(xOffset, offset), radius-minRadius+(maxRadius + minRadius) /2, wavePaint);

    }

    wavePaint..color = Colors.blue;
    canvas.drawCircle(Offset(xOffset, offset), minRadius, wavePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
