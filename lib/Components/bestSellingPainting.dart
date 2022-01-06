
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'nikemarkClipper.dart';

class BestSellerPaintings extends StatelessWidget {

  final String imagePath;
  final String name;
  final String price;
  const BestSellerPaintings({
    Key? key, required this.imagePath, required this.name, required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left : 10),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       Container(
         height: 50,
         width : 50,
         child: Stack(
           children: [
             Container(
             width: 40,
             height: 40,
              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                      imagePath
                                       ),
                                    fit: BoxFit.cover)
                                    ),
           ),
           Positioned(
             left : 25,
             bottom : 30,
             child: ClipPath(
               clipper: NikeMarkClipper(),
               child: Container(
                 decoration: BoxDecoration(
                   color : Colors.green[400]
                 ),
                 width : 20,
                 height: 20,
                child: Icon(Icons.check_rounded , size: 10,color: Colors.white,),
               ),
             ),
           )
           
           ]
         ),
       ),
       Container(
         height: 50,
         width : 100,
        margin: EdgeInsets.only(top : 10,left: 5),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(name, style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize:11))),
             Text(price+"\$",style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w600,
                                          fontSize:11)))
           ],
         ),
       )
      ],
      
    
      ),
    );
  }
}