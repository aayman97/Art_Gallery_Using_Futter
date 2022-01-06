import 'package:flutter/material.dart';

class NikeMarkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
   Path path_0 = Path();
    path_0.moveTo(size.width*0.2500000,size.height*0.06945102);
    path_0.lineTo(0,size.height*0.5000020);
    path_0.lineTo(size.width*0.2500000,size.height*0.9305490);
    path_0.lineTo(size.width*0.7500000,size.height*0.9305490);
    path_0.lineTo(size.width,size.height*0.5000020);
    path_0.lineTo(size.width*0.7500000,size.height*0.06945102);
    path_0.lineTo(size.width*0.2500000,size.height*0.06945102);
    path_0.close();
    


    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

  
}