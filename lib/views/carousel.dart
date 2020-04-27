import 'dart:math';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterappadaya/methods/sharedValues.dart';
import 'package:flutterappadaya/model/Fav.dart';
import 'package:flutterappadaya/model/Shikh.dart';
import 'package:flutterappadaya/model/Sura.dart';
import 'package:flutterappadaya/styles/appStyle.dart';
import 'package:flutterappadaya/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutterappadaya/views/controles.dart';

class DoaaCarousel extends StatefulWidget {
  @override
  _DoaaCarouselState createState() => _DoaaCarouselState();
}

class _DoaaCarouselState extends State<DoaaCarousel> {
  String ShikhName = " ... جارى التحميل ";
  String filterName = "الكل";
  IconData filterIcon = Icons.filter_list;
  bool loaded = false;
  static Widget loading = Container(
    width: 120,
    height: 120,
    child: Padding(
      child: CircularProgressIndicator(),
      padding: EdgeInsets.all(120),
    ),
  );
  Widget loadScreen = loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((r) {
      // r for response
      String v = r.getString('shikh'); // v for value
      setState(() {
        ShikhName = Shikh.names[v];
      });
    });

    _loadSewar().then((r) {
      setState(() {
        loadScreen = buildCarouselSlider(context, r, true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Text(filterName, style: topContainerText),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              filterIcon,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.all(0),
                              titlePadding: EdgeInsets.all(0),
                              title: Container(
                                  decoration: BoxDecoration(
                                    color: ayaDetailBb,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Center(
                                        child: Text(
                                      "اختر قائمة العرض",
                                      style: topContainerText,
                                    )),
                                  )),
                              elevation: 0,
                              //backgroundColor: Colors.transparent,
                              content: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20))),
                                child: ListView.builder(
                                    itemCount: Shikh.filtrationTypes.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(
                                          Shikh.filtrationTypes.values
                                              .toList()[index],
                                          style: popUpText,
                                          textDirection: TextDirection.rtl,
                                        ),
                                        trailing: Icon(Shikh
                                            .filtrationTypes.keys
                                            .toList()[index]),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          filterDisplay(
                                              Shikh.filtrationTypes.values
                                                  .toList()[index],
                                              Shikh.filtrationTypes.keys
                                                  .toList()[index]);
                                        },
                                      );
                                    }),
                              ),
                            );
                          });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.all(0),
                              titlePadding: EdgeInsets.all(0),
                              title: Container(
                                  decoration: BoxDecoration(
                                    color: ayaDetailBb,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Center(
                                        child: Text(
                                      "اختر الشيخ المفضل للسماع",
                                      style: topContainerText,
                                    )),
                                  )),
                              elevation: 0,
                              //backgroundColor: Colors.transparent,
                              content: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(20)),
                                ),
                                child: ListView.builder(
                                    itemCount: Shikh.names.length,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        trailing: Icon(
                                          ShikhName ==
                                                  Shikh.names.values
                                                      .toList()[index]
                                              ? Icons.check_box
                                              : Icons.headset,
                                          color: ayaDetailBb,
                                        ),
                                        title: Text(
                                            Shikh.names.values.toList()[index],
                                            style: popUpText,
                                            textDirection: TextDirection.rtl),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _setPrefShikh(
                                              Shikh.names.keys.toList()[index]);
                                        },
                                      );
                                    }),
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(ShikhName, style: topContainerText),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.headset,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            loadScreen,
            BuildContainerControl(),
          ],
        ),
      ),
    );
  }

  CarouselSlider buildCarouselSlider(
      BuildContext context, List<Fav> f, bool infinityScroll) {
    favList = f;
    current = Random().nextInt(f.length);
    return CarouselSlider.builder(
      initialPage: current,
      itemCount: f.length,
      enableInfiniteScroll: infinityScroll,
      height: MediaQuery.of(context).size.height / 1.9,
      onPageChanged: (v) {
        print(v.toString());
        setState(() {
          current = v;
          print(current);
        });
      },
      itemBuilder: (BuildContext context, int i) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Text(
                      f[i].text,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'ge ss',
                          fontWeight: FontWeight.bold,
                          color: ayaDetailBb),
                    )),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.fill)),
                  //color: Colors.white,
                ),
              ),

              // sura of aya and aya num
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      color: ayaDetailBb),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("آية رقم  : " + f[i].index,
                            style: topContainerText),
                        Text(
                          "سورة : " + f[i].swra,
                          style: topContainerText,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<List<Fav>> _loadSewar() async {
    //print("i'm out");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_open') == null) {
      prefs.setString('shikh', 'ar.alafasy');
      prefs.setBool('first_open', true);
      Sura s = new Sura();
      return await s.jsonFileLoad();
    } else {
      var db = new DatabaseHelper();
      List<Fav> result = await db.getAll();
      return result;
    }
  }

  Future<List<Fav>> _loadFav() async {
    setState(() {
      loadScreen = loading;
    });
    var db = new DatabaseHelper();
    List<Fav> result = await db.getFav();
    return result;
  }

  currentIsFav() {
    setState(() {
      heart = Icons.favorite;
    });
  }

  _setPrefShikh(String shikhKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('shikh', shikhKey);
    String v = prefs.getString('shikh'); //change to the preference value
    setState(() {
      ShikhName = Shikh.names[v];
    });
  }

  void filterDisplay(String filterType, IconData icon) {
    if (filterType == "الكل") {
      print("All");
      _loadSewar().then((r) {
        setState(() {
          filterName = "الكل";
          filterIcon = icon;
          loadScreen = buildCarouselSlider(context, r, true);
        });
      });
    } else if (filterType == "المفضلة") {
      print("favorit");
      _loadFav().then((r) {
        setState(() {
          filterName = "المفضلة";
          filterIcon = icon;
          if (r.isEmpty) {
            print("Empaty");
            loadScreen = Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: EdgeInsets.all(20),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "عفوا لا يوجد قائمة مفضلة لديك ",
                    style: topContainerText,
                  ),
                  SizedBox.fromSize(
                    size: Size.square(20),
                  ),
                  RaisedButton(
                    onPressed: () => filterDisplay("الكل", Icons.filter_list),
                    child: Text(
                      "العودة للكل",
                      style: popUpText,
                    ),
                  ),
                ],
              ),
            );
          } else {
            loadScreen = buildCarouselSlider(context, r, false);
          }
        });
      });
    } else {
      print("none of thes");
    }
  }
}
