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

class _HomeScreenState extends State<HomeScreen> {
  List _items = [];
  double _pageoffset = 0;
  int currentIndex = 0;
  double _opacity = 1.0;

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
    super.initState();
    controller.addListener(() {
      setState(() {
        _pageoffset = controller.page!;
      });
    });
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
                        return Center(
                          child: Text('Loading'),
                        );
                      }
                    },
                  ),
           BestSellerTextAndIcon("Trending"),
            SizedBox(
              height: 500,
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


}
