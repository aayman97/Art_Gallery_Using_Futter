import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceAbidButton extends StatefulWidget {

  final int itemIndex;
  final int currentIndex;
  PlaceAbidButton({Key? key, required this.itemIndex, required this.currentIndex}) : super(key: key);

  @override
  _PlaceAbidButtonState createState() => _PlaceAbidButtonState(itemIndex,currentIndex);
}

class _PlaceAbidButtonState extends State<PlaceAbidButton> with TickerProviderStateMixin{


  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  var currentIndex;
  var itemIndex;

  _PlaceAbidButtonState(this.itemIndex, this.currentIndex);
  





    @override
  void dispose() {
     _controller.dispose();
    super.dispose();
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
_controller = AnimationController(
  duration: Duration(seconds:4),
  vsync: this,

  );
    
_opacityAnimation= TweenSequence<double>(
      [
        TweenSequenceItem(
          weight: 90.0,
          tween: Tween(
            begin: 0.0,
            end:0.0,
          ),
        ),
        TweenSequenceItem(
          weight: 10.0,
          tween: Tween(
            begin: 0.0,
            end:1.0,
          )
          ,
        ),
      ],
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        print("Place A bid : "+itemIndex.toString());
      },
      child: AnimatedBuilder(
                 animation: _controller,
                                            builder:(BuildContext context,_){
                                              return 
                                               Opacity(
                                                 
                                                 opacity: _opacityAnimation.value,
                                                 child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  padding: EdgeInsets.all(12),
                                                  child: Text("Place a bid",style: GoogleFonts.poppins( textStyle: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 13
                                                              )))
                                                  
                                                                                         ),
                                               );
                                            } 
                                          ),
    );
  }
}