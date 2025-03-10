import 'package:flutter/material.dart';

class BatmanCon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<BatmanCon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Анимация от -500 (вне экрана) до 0 (внутри экрана)
    _animation = Tween<double>(begin: -500, end: -100).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Запускаем анимацию при открытии окна
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(10, _animation.value), // Перемещение по Y
            child: Transform.rotate(
              angle: -145 * (3.141592653589793238 / 180),
              child: Container(
                width: 500,
                height: 500,
                child: CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: MyCustomPainter(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.3, size.height * 0.6);

    path.quadraticBezierTo(
      size.width * 0.1, // Контрольная точка по X
      size.height * 0.4, // Контрольная точка по Y
      size.width * 0.3, // Конечная точка по X
      size.height * 0.5, // Конечная точка по Y
    );

    path.quadraticBezierTo(
      size.width * 0.5, // Контрольная точка по X
      size.height * 0.3, // Контрольная точка по Y
      size.width * 0.7, // Конечная точка по X
      size.height * 0.5, // Конечная точка по Y
    );

    path.quadraticBezierTo(
      size.width * 0.9, // Контрольная точка по X
      size.height * 0.4, // Контрольная точка по Y
      size.width * 0.7, // Конечная точка по X
      size.height * 0.6, // Конечная точка по Y
    );

    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.6);
    path.close(); // Замыкаем путь

    final paintFill = Paint()
      ..color = const Color.fromRGBO(233, 30, 99, 1)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paintFill);

    final paintStroke = Paint()
      ..color = Colors.black // Цвет линии
      ..strokeWidth = 6 // Толщина линии
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Не нужно перерисовывать
  }
}
