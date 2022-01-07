import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:art_gallery_using_flutter/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Components/bestSellingPainting.dart';
import 'Components/navbar.dart';
import 'Components/paintingContainer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Stack(children: [HomeScreen()]),
    Text(
      'EmptyScreen1',
      style: optionStyle,
    ),
    Text(
      'EmptyScreen2',
      style: optionStyle,
    ),
    Text(
      'EmptyScreen3',
      style: optionStyle,
    ),
    Text(
      'EmptyScreen4',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Center(child: _widgetOptions.elementAt(_selectedIndex)),
                BottomNavigationBar(width, height)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Align BottomNavigationBar(double width, double height) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          width: width,
          height: 90,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              CustomPaint(
                size: Size(width, 80),
                painter: RPSCustomPainter(),
              ),
              Center(
                heightFactor: 0.6,
                child: FloatingActionButton(
                    backgroundColor: Colors.blue[700],
                    child: Icon(
                      Icons.add,
                      size: 40,
                    ),
                    elevation: 0.1,
                    onPressed: () {}),
              ),
              ClipPath(
                clipper: PathClipper(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    width: width,
                    height: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 80,
                          child: Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.home_rounded,
                                  color: _selectedIndex == 0
                                      ? Colors.black
                                      : Colors.black,
                                  size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 0;
                                  });
                                },
                                splashColor: Colors.white,
                              ),
                              _selectedIndex == 0
                                  ? Positioned(
                                      left: width * 0.06,
                                      top: height * 0.055,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ))
                                  : Positioned(
                                      left: width * 0.05,
                                      top: height * 0.05,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                        color: Colors.transparent,
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          child: Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.search_rounded,
                                  color: _selectedIndex == 1
                                      ? Colors.black
                                      : Colors.black,
                                 size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 1;
                                  });
                                },
                                splashColor: Colors.white,
                              ),
                              _selectedIndex == 1
                                  ? Positioned(
                                   left: width * 0.06,
                                      top: height * 0.055,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ))
                                  : Positioned(
                                      left: width * 0.05,
                                      top: height * 0.05,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                        color: Colors.transparent,
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.20,
                        ),
                        Container(
                          height: 80,
                          child: Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.bookmark_rounded,
                                  color: _selectedIndex == 2
                                      ? Colors.black
                                      : Colors.black,
                                   size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 2;
                                  });
                                },
                                splashColor: Colors.white,
                              ),
                              _selectedIndex == 2
                                  ? Positioned(
                                      left: width * 0.06,
                                      top: height * 0.055,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ))
                                  : Positioned(
                                      left: width * 0.05,
                                      top: height * 0.05,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                        color: Colors.transparent,
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          child: Stack(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.person_rounded,
                                  color: _selectedIndex == 3
                                      ? Colors.black
                                      : Colors.black,
                                  size: 40,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _selectedIndex = 3;
                                  });
                                },
                                splashColor: Colors.white,
                              ),
                              _selectedIndex == 3
                                  ? Positioned(
                                     left: width * 0.06,
                                      top: height * 0.055,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ))
                                  : Positioned(
                                      left: width * 0.05,
                                      top: height * 0.05,
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                        color: Colors.transparent,
                                      ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.6190476, 0);
    path_0.cubicTo(
        size.width * 0.6190476,
        0,
        size.width * 0.6210095,
        size.height * 0.3014740,
        size.width * 0.6095238,
        size.height * 0.4100000);
    path_0.cubicTo(
        size.width * 0.5904762,
        size.height * 0.5900000,
        size.width * 0.5365143,
        size.height * 0.7219420,
        size.width * 0.5023810,
        size.height * 0.7200000);
    path_0.cubicTo(
        size.width * 0.4690529,
        size.height * 0.7181040,
        size.width * 0.4095238,
        size.height * 0.6000000,
        size.width * 0.3928571,
        size.height * 0.4100000);
    path_0.cubicTo(size.width * 0.3807843, size.height * 0.2723700,
        size.width * 0.3809524, 0, size.width * 0.3809524, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width * 0.6190476, 0);
    path_0.cubicTo(
        size.width * 0.6190476,
        0,
        size.width * 0.6210095,
        size.height * 0.3014740,
        size.width * 0.6095238,
        size.height * 0.4100000);
    path_0.cubicTo(
        size.width * 0.5904762,
        size.height * 0.5900000,
        size.width * 0.5365143,
        size.height * 0.7219420,
        size.width * 0.5023810,
        size.height * 0.7200000);
    path_0.cubicTo(
        size.width * 0.4690529,
        size.height * 0.7181040,
        size.width * 0.4095238,
        size.height * 0.6000000,
        size.width * 0.3928571,
        size.height * 0.4100000);
    path_0.cubicTo(size.width * 0.3807843, size.height * 0.2723700,
        size.width * 0.3809524, 0, size.width * 0.3809524, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.close();

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_0_stroke.color = Colors.black.withOpacity(0.0);
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(0.8);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
