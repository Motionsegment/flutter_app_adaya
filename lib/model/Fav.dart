import 'dart:convert';

import 'package:flutterappadaya/methods/sharedValues.dart';
import 'package:flutterappadaya/utils/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Fav
{
  int _id;
  String _swra;
  String _swraIndex;
  String _text;
  String _index;
  int _isFav;


  set isFav(int value) {
    _isFav = value;
  }
  set swraIndex(String value) {
    _swraIndex = value;
  }
  set id(int value) {
    _id = value;
  }
  set swra(String value) {
    _swra = value;
  }

  set text(String value) {
    _text = value;
  }

  set index(String value) {
    _index = value;
  }


  int get id => _id;
  String get swra => _swra;
  String get text => _text;
  String get index => _index;
  int get isFav => _isFav;
  String get swraIndex => _swraIndex;



  Fav(this._swra ,this._swraIndex, this._text ,this._index,this._isFav);


  @override
  String toString() {
    return "id:${this.id} , swra: ${this.swra} , swraIndex: ${this.swraIndex} , text: ${this.text}";
  }

  Fav.map(dynamic obj){
    this.swra = obj["swraName"];
    this.swraIndex = obj["swraIndex"];
    this.text = obj["text"];
    this.index = obj["ayaIndex"];
    this.isFav = obj["isFave"];
    this.id =obj["id"];
  }

  Fav.fromMap(Map<String , dynamic> map){
    this.swra = map["swraName"];
    this.swraIndex = map["swraIndex"];
    this.text = map["text"];
    this.index = map["ayaIndex"];
    this.isFav =map["isFave"];
    this.id = map["id"];
  }

  Map<String,dynamic> toMap()
  {

    /*
     id |  swraName | text | index
     -----------------------------
     1  |
     2  |

    */
    var map = Map<String,dynamic>();

    if(_id != null)
      map['id']= this._id;


    map['swraName'] = this.swra;
    map['swraIndex'] = this.swraIndex;
    map['text'] = this.text;
    map['ayaIndex'] = this.index;
    map["isFave"] = this.isFav;

    return map;
  }



  Future<List<String>> getAudioUrl(String shikh) async {

    List<String> url =[];
    List<String> urlAudio = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('shikh') == null) {
      prefs.setString('shikh', 'ar.alafasy');
    }
    String shikh = prefs.getString('shikh');

    if((this.index).contains('-'))
      {

        List<String> ayatNo = (this.index).split('-'); //split ayat numbers
        for (var i = int.parse(ayatNo[0]); i <= int.parse(ayatNo[1]);i++) {

          String preparedUrl = await prepareUrl(this.swraIndex, i.toString(), shikh);
          urlAudio.add(preparedUrl);
        }

      }
    else
      {
      print("its only one");
//      url.add('http://api.alquran.cloud/v1/ayah/${this.swraIndex}:${this.index}');
//      var res = await http.get(url[0]);
//      var body = json.decode(res.body);
//
//      var number = body['data']['number'];
        String preparedUrl =  await prepareUrl(this.swraIndex, this.index, shikh);
        urlAudio.add(preparedUrl);

      }

    //print("url :" + url.toString());

    print("urlAudio :" + urlAudio.toString());
    return urlAudio;
  }


  int updateFave()
  {
    var db = new DatabaseHelper();
    this.isFav == 1 ? this.isFav = 0 : this.isFav = 1;

    db.updateFave(this);
    return 1;
  }

  Future<String> prepareUrl(String swraIndex ,String index ,String shikh) async{
    String url = 'http://api.alquran.cloud/v1/ayah/$swraIndex:$index';
    var res = await http.get(url);
    var body = json.decode(res.body);

    var number = body['data']['number'];
    url =  "https://cdn.islamic.network/quran/audio/64/$shikh/$number.mp3";
    return url;
  }





}