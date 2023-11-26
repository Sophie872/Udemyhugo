import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.5);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.5,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.75,
      size.width,
      size.height * 0.5,
    );

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LinearCubicCurvePainter extends CustomPainter {
  final String imageAboveUrl;
  final String imageBelowUrl;

  LinearCubicCurvePainter(this.imageAboveUrl, this.imageBelowUrl);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Color(0xFF041060));
    canvas.translate(size.width / 2, 0);

    final width = size.width / 2;

    Path bezierPath = Path()
      ..moveTo(width, size.height)
      ..lineTo(width, size.height * 0.2)
      ..cubicTo(
        width * 0.8,
        size.height * 0.6,
        0,
        size.height * 0.4,
        -width,
        size.height * 0.8,
      )
      ..lineTo(-width, size.height);

    final bezierPaint = Paint()
      ..shader = LinearGradient(colors: [
        Colors.blue[900]!,
        Colors.blue[900]!,
      ]).createShader(Rect.fromLTWH(-width, 0, size.width, size.height));

    canvas.drawPath(bezierPath, bezierPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: LinearCubicCurvePainter(
          'https://cdn.glitch.global/4feb09f7-c891-4c1a-bb18-cb3ef202f592/1a043383-cfbc-4939-879e-2c3767c50a1c.png?v=1700836291668',
          'https://cdn.glitch.global/1fbac8ff-a36e-42c4-8a8c-07713cc90c2f/6f17a49d-beac-4ac8-b632-54c944aa0649.png?v=1700956065076',
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                child: ImageWithText(
                  imageUrl:
                      'https://cdn.glitch.global/4feb09f7-c891-4c1a-bb18-cb3ef202f592/1a043383-cfbc-4939-879e-2c3767c50a1c.png?v=1700836291668',
                  text: 'Profesor',
                  height: 150,
                  width: 300,
                  fontSize: 24,
                ),
              ),
            ),
            Positioned(
              bottom: 80, 
              right: 20,
              child: Container(
                padding: EdgeInsets.all(20),
                child: ImageWithText(
                  imageUrl:
                      'https://cdn.glitch.global/1fbac8ff-a36e-42c4-8a8c-07713cc90c2f/6f17a49d-beac-4ac8-b632-54c944aa0649.png?v=1700956065076',
                  text: 'Estudiante',
                  height: 150,
                  width: 300,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageWithText extends StatelessWidget {
  final String imageUrl;
  final String text;
  final double height;
  final double width;
  final double fontSize;

  ImageWithText({
    required this.imageUrl,
    required this.text,
    this.height = 150,
    this.width = 150,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          imageUrl,
          height: height,
          width: width,
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontFamily: 'TT CHOCOLATE',
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second_page': (context) => SecondPage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/second_page');
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  right: 80,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationX(0),
                    child: ClipPath(
                      clipper: BezierClipper(),
                      child: Container(
                        color: Colors.grey,
                        height: 200,
                        width: 350,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    padding: EdgeInsets.all(90),
                    child: Image.network(
                      'https://cdn.glitch.global/3de769ad-c961-4946-8a31-03b1836d0ce9/Presentaci%C3%B3n%20aplicaci%C3%B3n%20m%C3%B3vil%20completa%20y%20vers%C3%A1til%20moderna%20azul%20y%20violetaX2.jpg?v=1700589452873',
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  left: 80,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(-10),
                    child: ClipPath(
                      clipper: BezierClipper(),
                      child: Container(
                        color: Colors.blue,
                        height: 200,
                        width: 350,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
