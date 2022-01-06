  import 'package:art_gallery_using_flutter/Components/placeAbidbutton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Center paintingConatiner(int itemIndex, double height, double _pageoffset,  List _items, int currentIndex) {
    Matrix4 matrix = new Matrix4.identity();

    double angle = (_pageoffset - itemIndex).abs();

    if (_pageoffset.floor() == itemIndex) {
      double currScale = 1 - (_pageoffset - itemIndex) * 0.18;
      double currTrans = height * (1 - currScale) / 4;

      if (angle > 0.5) {
        angle = 1 - angle;
      }
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0)
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle);
    } else if (_pageoffset.floor() + 1 == itemIndex) {
      double currScale = 0.82 + (_pageoffset - itemIndex + 1) * 0.18;
      double currTrans = height * (1 - currScale) / 4;

      if (angle > 0.5) {
        angle = 1 - angle;
      }
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0)
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle);
    } else if (_pageoffset.floor() - 1 == itemIndex) {
      double currScale = 0.82;
      double currTrans = height * (1 - currScale) / 4;

      if (angle > 0.5) {
        angle = 1 - angle;
      }
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0)
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle);
    } else {
      double currScale = 0.82;
      double currTrans = height * (1 - currScale) / 4;

      if (angle > 0.5) {
        angle = 1 - angle;
      }
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0)
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle);
    }

    return Center(
      child: Transform(
        transform: matrix,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: 450,
          height: height * 0.9,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage(
                      width: 450,
                      height: height * 0.85,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/placeholder.png'),
                      image: AssetImage(_items[itemIndex]['painting']))),
              Container(
                width: double.infinity,
                height: height * 0.85,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff343945),
                          borderRadius: BorderRadius.circular(20)),
                      width: double.infinity,
                      height: (height * 0.85) * 0.22,
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 22),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 210,
                                  child: Text(_items[itemIndex]['name'],
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13))
                                              ),
                                ),
                                Container(
                                  child: Text("December 1884",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13))),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Avatar.jpg'),
                                              fit: BoxFit.cover)
                                              ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text('Vincent Van Gogh',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10))),
                                    )
                                  ],
                                ),
                                Container(
                                  child: Text(
                                      "" +
                                          ((itemIndex + 1) * 10000.0)
                                              .toString() +
                                          "\$",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.3),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13))),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    PlaceAbidButton(
                      currentIndex: currentIndex,
                      itemIndex: itemIndex,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }