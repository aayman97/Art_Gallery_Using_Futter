
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        
        child: BackdropFilter(
           filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
          decoration: BoxDecoration(
            color : Colors.white.withOpacity(0.7)
          ),
          padding: EdgeInsets.all(10),
          width : width,
          height: height*0.08,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                
                children: [
                  Image.asset("assets/images/nftz.png", width: width*0.12,height: height*0.08,fit: BoxFit.contain,),
                    Container(
                      height: height*0.08,
                      margin: EdgeInsets.only(left : 10, top : 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment : CrossAxisAlignment.center,
                        children: [
                          Text("VANG",style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:25))
                                                  ),
        
                            Container(
                              margin: EdgeInsets.only(top : 13,left: 2),
                              child: Icon(Icons.circle, size: 5, color: Colors.amber,))
                        ],
                      ),
                    ),
        
                
                ],
              ),
              Icon(Icons.menu_rounded, size: 40,),
            ],),
          ),
                  ),
        ),
      ),
    );
  }
}