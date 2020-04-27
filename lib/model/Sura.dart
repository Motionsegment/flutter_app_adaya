import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutterappadaya/methods/SelctedAya.dart';
import 'package:flutterappadaya/model/Fav.dart';
import 'package:flutterappadaya/utils/database_helper.dart';

import 'Aya.dart';
import 'dart:convert';

class Sura
{
  final String id;
  final String name;
  final List<Aya> aya;


  Sura({this.id, this.name, this.aya});




  factory Sura.fromJson(Map<String, dynamic> json) {

    List<dynamic> list = json["aya"] as List;
    List<Aya> ay = list.map((i) => Aya.fromJson(i)).toList();
    return new Sura(id: json["index"],name:json["name"],aya: ay);
  }



  @override
  String toString() {
    String result = "${name},${id}";
    return result;
  }

   Future<List<Fav>> jsonFileLoad()  async {
    //List<String> ss = [];
    String data = await rootBundle.loadString("assets/json_files/aq.json");
    var db = new DatabaseHelper();
    List<Sura> swer = parseJosn(data);
    swer.forEach((s) {
      //ss.add(" \" ${s.name} \" ");
      selectedAya(s).forEach((a){
            db.insertFav(new Fav(s.name,s.id,a.txt, a.id, 0));
      });
    });
    //print(ss.toString());
    return db.getAll();
  }

  List<Sura> parseJosn(String response) {
    List<dynamic> jsonresponse = jsonDecode(response) as List;
    List<Sura> surs = jsonresponse.map((i) => Sura.fromJson(i)).toList();
    List<Sura> selected_surs = [
      surs[suraIndex(2)],surs[suraIndex(3)],
      surs[suraIndex(4)],surs[suraIndex(5)],
      surs[suraIndex(7)],surs[suraIndex(9)],
      surs[suraIndex(10)],surs[suraIndex(11)],
      surs[suraIndex(12)],surs[suraIndex(14)],
      surs[suraIndex(17)],surs[suraIndex(18)],
      surs[suraIndex(19)],surs[suraIndex(20)],
      surs[suraIndex(21)],surs[suraIndex(23)],
      surs[suraIndex(25)],surs[suraIndex(26)],
      surs[suraIndex(27)],surs[suraIndex(28)],
      surs[suraIndex(29)],surs[suraIndex(30)],
      surs[suraIndex(37)],surs[suraIndex(38)],
      surs[suraIndex(40)],surs[suraIndex(43)],
      surs[suraIndex(44)],surs[suraIndex(46)],
      surs[suraIndex(54)],surs[suraIndex(59)],
      surs[suraIndex(60)],surs[suraIndex(66)],
      surs[suraIndex(71)]
    ] ;

    return selected_surs;
  }

  int suraIndex(int id)=> id-1;

}


//ListView.builder(
//itemCount: Shikh.filtrationTypes.length,
//shrinkWrap: true,
//itemBuilder: (BuildContext context, int index) {
//return ListTile(
//title: Text(Shikh.filtrationTypes.values.toList()[index],
//style: popUpText, textDirection: TextDirection.rtl,),
//trailing:Icon(Shikh.filtrationTypes.keys.toList()[index]) ,
//onTap: () {
//Navigator.of(context).pop();
//filterDisplay(Shikh.filtrationTypes.values.toList()[index],Shikh.filtrationTypes.keys.toList()[index]);
//},
//);
//})