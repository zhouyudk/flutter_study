import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this)
      ..repeat();
    _animation = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          }));
  }

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   child: CustomPaint(
    //     painter: MaskFilterPainter(animationValue: _animation.value),
    //   ),
    //   onTap: () {
    //     _controller.repeat();
    //   },
    // );
    // return Center(
    //     child: Container(
    //   width: 100,
    //   height: 100,
    //   // color: Colors.blue,
    //   decoration: BoxDecoration(
    //       border: Border.all(color: Colors.blue, width: 5),
    //       borderRadius: BorderRadius.all(Radius.circular(5))),
    // ));
    return Center(
        child: BorderPath(
      child: Container(
        height: 100,
        width: 200,
        color: Colors.black,
      ),
      animation: _controller,
      borderColor: Colors.red,
      borderWidth: 5,
    ));
    /*
    return Center(
        child: Container(
      child: SizedBox(height: 100, width: 300,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        gradient: const SweepGradient(
          colors: [
            Color.fromARGB(255, 250, 5, 98),
            Color.fromARGB(255, 32, 248, 172),
            Color.fromARGB(255, 21, 67, 239),
            Color.fromARGB(255, 250, 5, 98),
          ],
          stops: [
            0,
            0.45,
            0.6,
            1,
          ],
        ),
        // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
    ));
    */
  }

  Widget _chatListItemBuilder(BuildContext context, int index) {
    return const SizedBox();
  }

  Widget _chatListSearchItem() {
    return SizedBox();
  }

  Widget _chatListNormalItem() {
    return SizedBox();
  }
}

class _GradientBoarderPainter extends CustomPainter {
  _GradientBoarderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    var center = Offset(size.width / 2, size.height / 2);
    var radius = 80.0;
    paint.color = Colors.blue[400]!;
    paint.maskFilter = const MaskFilter.blur(BlurStyle.outer, 20.0);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw false;
  }
}

class MaskFilterPainter extends CustomPainter {
  double animationValue;
  MaskFilterPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.style = PaintingStyle.fill;
    _drawMovingCircle(canvas, size, paint);
    //_drawMultiMovingRect(canvas, size, paint);
    //_drawMultiMovingCircle(canvas, size, paint);
    // _drawRectsUsingBezier(canvas, size, paint);
    // 效果对比绘制
    // var center = Offset(size.width / 2, size.height / 2);
    // var radius = 80.0;
    // paint.color = Colors.blue[400]!;
    // paint.maskFilter = MaskFilter.blur(BlurStyle.outer, 20.0);
    // canvas.drawCircle(center, radius, paint);
  }

  void _drawMovingCircle(Canvas canvas, Size size, Paint paint) {
    var radius = 80.0;
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black87,
        Colors.purple,
        Colors.blue,
        Colors.green,
        Colors.yellow[500]!,
        Colors.orange,
        Colors.red[400]!
      ].reversed.toList(),
      tileMode: TileMode.clamp,
      transform: GradientRotation(
        animationValue * 2 * pi,
      ),
    ).createShader(Offset(0, 0) & size);

    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 20.0);
    canvas.drawCircle(
        Offset(size.width / 2, size.height * animationValue), radius, paint);
  }

  void _drawMultiMovingRect(Canvas canvas, Size size, Paint paint) {
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black87,
        Colors.purple,
        Colors.blue,
        Colors.green,
        Colors.yellow[500]!,
        Colors.orange,
        Colors.red[400]!
      ].reversed.toList(),
      tileMode: TileMode.clamp,
      transform: GradientRotation(
        animationValue * 2 * pi,
      ),
    ).createShader(Offset(0, 0) & size);

    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 20.0);
    var count = 10;
    for (var i = 0; i < count + 1; ++i) {
      canvas.drawRect(
        Offset(size.width / count * i, size.height * animationValue) &
            Size(size.width / count, size.width / count * 2),
        paint,
      );
    }
  }

  void _drawMultiMovingCircle(Canvas canvas, Size size, Paint paint) {
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black87,
        Colors.purple,
        Colors.blue,
        Colors.green,
        Colors.yellow[500]!,
        Colors.orange,
        Colors.red[400]!
      ].reversed.toList(),
      tileMode: TileMode.clamp,
      transform: GradientRotation(
        animationValue * 2 * pi,
      ),
    ).createShader(Offset(0, 0) & size);

    paint.maskFilter = MaskFilter.blur(BlurStyle.outer, 20.0);
    var count = 10;
    for (var i = 0; i < count + 1; ++i) {
      canvas.drawCircle(
        Offset(size.width * i / count * animationValue,
            size.height * i / count * animationValue),
        size.width / count,
        paint,
      );
    }
  }

  void _drawRectsUsingBezier(Canvas canvas, Size size, Paint paint) {
    paint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.black87,
        Colors.purple,
        Colors.blue,
        Colors.green,
        Colors.yellow[500]!,
        Colors.orange,
        Colors.red[400]!
      ].reversed.toList(),
      tileMode: TileMode.clamp,
      transform: GradientRotation(
        animationValue * 2 * pi,
      ),
    ).createShader(Offset(0, 0) & size);

    paint.maskFilter = MaskFilter.blur(BlurStyle.outer, 2);
    final height = 120.0;
    var p0 = Offset(0, size.height / 2 + height);
    var p1 = Offset(size.width / 4, size.height / 2 - height);
    var p2 = Offset(size.width * 3 / 4, size.height / 2 + height);
    var p3 = Offset(size.width, size.height / 2 - height);
    var count = 150;
    var squareSize = 20.0;
    for (var t = 1; t <= count; t += 1) {
      var curvePoint =
          BezierUtil.get3OrderBezierPoint(p0, p1, p2, p3, t / count);

      canvas.drawRect(
        curvePoint & Size(squareSize, squareSize),
        paint,
      );
    }

    for (var t = 1; t <= count; t += 1) {
      var curvePoint =
          BezierUtil.get3OrderBezierPoint(p3, p1, p2, p0, t / count);

      canvas.drawRect(
        curvePoint & Size(squareSize, squareSize),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BezierUtil {
  static Offset get2OrderBezierPoint(
      Offset p1, Offset p2, Offset p3, double t) {
    var x = (1 - t) * (1 - t) * p1.dx + 2 * t * (1 - t) * p2.dx + t * t * p3.dx;
    var y = (1 - t) * (1 - t) * p1.dy + 2 * t * (1 - t) * p2.dy + t * t * p3.dy;

    return Offset(x, y);
  }

  static Offset get3OrderBezierPoint(
      Offset p1, Offset p2, Offset p3, Offset p4, double t) {
    var x = (1 - t) * (1 - t) * (1 - t) * p1.dx +
        3 * t * (1 - t) * (1 - t) * p2.dx +
        3 * t * t * (1 - t) * p3.dx +
        t * t * t * p4.dx;
    var y = (1 - t) * (1 - t) * (1 - t) * p1.dy +
        3 * t * (1 - t) * (1 - t) * p2.dy +
        3 * t * t * (1 - t) * p3.dy +
        t * t * t * p4.dy;

    return Offset(x, y);
  }
}

class BorderPath extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final Animation<double> animation;

  const BorderPath(
      {Key? key,
      required this.child,
      required this.borderColor,
      required this.borderWidth,
      required this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleHaloPainter(animation),
      child: child,
    );
  }
}

class BorderPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  double animationValue;

  BorderPainter(this.borderColor, this.borderWidth,
      {required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      // ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black87,
          Colors.purple,
          Colors.blue,
          Colors.green,
          Colors.yellow[500]!,
          Colors.orange,
          Colors.red[400]!
        ].reversed.toList(),
        tileMode: TileMode.clamp,
        transform: GradientRotation(
          animationValue * 2 * pi,
        ),
      ).createShader(const Offset(0, 0) & size);

    var path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) {
    return true;
  }
}

class CircleHaloPainter extends CustomPainter {
  Animation<double> animation;

  CircleHaloPainter(this.animation) : super(repaint: animation);

  final Animatable<double> rotateTween = Tween<double>(begin: 0, end: 2 * pi)
      .chain(CurveTween(curve: Curves.easeIn));

  final Animatable<double> breatheTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 4),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 4, end: 0),
        weight: 1,
      ),
    ],
  ).chain(CurveTween(curve: Curves.decelerate));

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    var path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    List<Color> colors = const [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0829FB),
      Color(0xFFF60C0C),
    ];

    final List<double> pos =
        List.generate(colors.length, (index) => (index + 1) / colors.length);

    paint.shader = SweepGradient(
        colors: colors,
        stops: pos,
        transform: GradientRotation(
          animation.value * 2 * pi,
        )).createShader(const Offset(0, 0) & size);

    paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));

    canvas.drawPath(path, paint);
    // canvas.rotate(animation.value * 2 * pi);
    // canvas.save();
    // canvas.rotate(animation.value * 2 * pi);
    // paint
    //   ..style = PaintingStyle.fill
    //   ..color = Color(0xff00abf2);
    // paint.shader = null;
    // // canvas.drawPath(path, paint);
    // canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}

//原版的发光彩色动画圆形代码
/*
class CircleHaloPainter extends CustomPainter {
  Animation<double> animation;

  CircleHaloPainter(this.animation) : super(repaint: animation);

  final Animatable<double> breatheTween = TweenSequence<double>(
    <TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 4),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 4, end: 0),
        weight: 1,
      ),
    ],
  ).chain(CurveTween(curve: Curves.decelerate));

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path circlePath = Path()
      ..addOval(Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100));

    List<Color> colors = [
      Color(0xFFF60C0C), Color(0xFFF3B913), Color(0xFFE7F716), 
      Color(0xFF3DF30B), Color(0xFF0DF6EF),  Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    colors.addAll(colors.reversed.toList());
    final List<double> pos = List.generate(colors.length, (index) => index / colors.length);
    
    paint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, 0, 2 * pi);
    
    paint.maskFilter =
        MaskFilter.blur(BlurStyle.solid, breatheTween.evaluate(animation));
    
    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CircleHaloPainter oldDelegate) =>
      oldDelegate.animation != animation;
}*/