import 'package:flutter/material.dart';
import 'package:flutterappadaya/styles/appStyle.dart';


class Bg extends StatefulWidget {


  @override
  _BgState createState() => _BgState();
}

class _BgState extends State<Bg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الادعية المذكورة في القرآن",style: TextStyle(color: Colors.green,fontFamily:'GE SS' ),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        //toolbarOpacity: 0.8,
        elevation: 0.0,
      ),
        body:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/1.14,
                  width: MediaQuery.of(context).size.width,
                  //margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    boxShadow:[BoxShadow(color: Colors.black87, blurRadius: 5.0,)],
                    gradient:LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [bg,gbg1]
                    ) ,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:Radius.circular(50) ),
                  ),

                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    //height: MediaQuery.of(context).size.height/4,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/bottom_decoration.png")),
                    ),
                    child: Image.asset("assets/images/bottom_decoration.png"),
                  ),
                ),
              ],
            )
          ],
        )
    );
  }
}
