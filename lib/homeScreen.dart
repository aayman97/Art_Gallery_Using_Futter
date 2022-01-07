import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Components/bestSellingPainting.dart';
import 'Components/navbar.dart';
import 'Components/paintingContainer.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>  with TickerProviderStateMixin{
  List _items = [];
  double _pageoffset = 0;
  int currentIndex = 0;
  double _opacity = 1.0;

   late AnimationController controllerForProgress;

  Future<void> ReadJsonData() async {
    final jsonfile = await rootBundle.loadString("assets/data.json");
    final data = await json.decode(jsonfile);

    setState(() {
      _items = data["items"];
    });
  }

  PageController controller = PageController(
    viewportFraction: 1,
  );

  initState() {
    controllerForProgress = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controllerForProgress.repeat(reverse: false);
    super.initState();
    controller.addListener(() {
      setState(() {
        _pageoffset = controller.page!;
      });
    });
  }

  @override
  void dispose() {
    controllerForProgress.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_items.isNotEmpty) {
      _items.map((e) => precacheImage(e['painting'], context));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [

          
            SingleChildScrollView(
              child: Column(
                children: [
          FakeNavBar(width, height),
            BestSellerTextAndIcon("Best Sellers"),
           BestSellersPaintingsBar(),
                  FutureBuilder(
                    future: ReadJsonData(),
                    builder: (context, data) {
                      if (_items.isNotEmpty) {
                        return Center(
                          child: Container(
                              decoration: BoxDecoration(color: Colors.transparent),
                              // you may want to use an aspect ratio here for tablet support
                              height: height * 0.65,
                              width: width,
                              child: PageView.builder(
                                onPageChanged: (value) {
                                  setState(() {
                                    currentIndex = value;
                                  });
                                },
                                itemCount: _items.length,
                                controller: controller,
                                itemBuilder: (BuildContext context, int itemIndex) {
                                  return paintingConatiner(itemIndex, height * 0.65,_pageoffset,_items,currentIndex);
                                },
                              )),
                        );
                      } else {
                        return Container(
                          width : width,
                          height: height*0.8,
                          child: Center(
                            child: CircularProgressIndicator(
              value: controllerForProgress.value,
              semanticsLabel: 'Linear progress indicator',
            ),
                          ),
                        );
                      }
                    },
                  ),
           _items.isNotEmpty ? BestSellerTextAndIcon("Trending") : Container(),
          Column(
            children: _items.isNotEmpty ? TrendingBanners(width,height) : [],
          ),
              _items.isNotEmpty ? BestSellerTextAndIcon("Hot new items") : Container(),
          Row(
            children: _items.isNotEmpty ? AfterTrendingBanners(width,height) : [],
          ),
           SizedBox(
             height: 100,
           )

                ],
              ),
            ),

              Navbar(width: width, height: height),
          ],
        ),
      ),
    );
  }

  SizedBox FakeNavBar(double width, double height) {
    return SizedBox(
          
            width : width,
            height: height*0.08,

          );
  }

  Container BestSellersPaintingsBar() {
    return Container(
               
                child: Row(
                  
                  children: [
                  BestSellerPaintings(imagePath:'assets/images/The_Starry_Night_low.jpg', name: "The Starry Night",price: "100,000",),
                  BestSellerPaintings(imagePath:'assets/images/Self-portrait_low.jpg', name: "Self Portrait",price: "70,000",),
                ],),
              );
  }

  Container BestSellerTextAndIcon(String text) {
    return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text(text, style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:20))),
                Icon(Icons.arrow_forward_ios_rounded, size: 25,)
              ]
            ),
          );
  }

  List<Widget>TrendingBanners(double width, double height) {

     List<Widget> widgets = [];

      for(int i =1;i< 4 ;i++){

        if(_items.isNotEmpty){
          widgets.add(
          Container(
            width : width*0.9,
            height: height*0.37,
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 4,
        offset: Offset(0, 1),
                )
              ]
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  child: Image.asset(_items[i]['painting'], width : double.infinity,height: (height*0.3)* 0.9,fit: BoxFit.fill,)
                  ),

                Container(
                  height: height*0.37 - (height*0.3)* 0.9,
                  width: width*0.9,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_items[i]["name"], style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize:20)),),
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
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10))
                                                    ),
                                      )
                                    ],
                                  ),
                      ],
                      ),

                      Container(
                        width: (width*0.9)*0.25,
                        height: (height*0.37 - (height*0.3)* 0.9)*0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Current bid",style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(1),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12))),
                            Text((i*127187).toString()+"\$", style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(1),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)))
                          ],
                        ),
                      )
                    ],
                  ),
                )


              ],
            )
          )

        );
        }
        
      }

  return widgets;

  }

  List<Widget>AfterTrendingBanners(double width, double height) {
     
     List<Widget> widgets = [];

      for(int i =1;i< 3 ;i++){
      
      widgets.add(
        Container(
          width:width*0.44,
          height: height *0.36,
           margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
           
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 4,
        offset: Offset(0, 1),
                )
              ]
            ),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(_items[i]['painting'], width: double.infinity, height: height*.2, fit: BoxFit.fill,)
                ),
                Container(
                  child: Text(_items[i]["name"], style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.5),
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 10))),
                ),
               Text("Art by Van Gogh...", style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(1),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12))),

                Text("Lorem ipsum tempor incididunt ut labore et dolore magna aliqua.", style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10))),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                        Text((i*517722).toString()+"\$", style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(1),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                Icon(Icons.arrow_forward_outlined)
                ],
              )
            ],
          ),
        ),
        )
      );

      }


    return widgets;
  }

 
}
