import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutterappadaya/methods/sharedValues.dart';
import 'package:flutterappadaya/model/Fav.dart';
import 'package:flutterappadaya/styles/appStyle.dart';
import 'package:share/share.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BuildContainerControl extends StatefulWidget {
  @override
  _BuildContainerControlState createState() => _BuildContainerControlState();
}

class _BuildContainerControlState extends State<BuildContainerControl> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  bool play = false;
  static Widget playAr = Icon(Icons.play_arrow, size: 50, color: ayaDetailBb);
  static Widget puseAr = Icon(Icons.pause, size: 50, color: ayaDetailBb);
  Widget _control = playAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //love button
            MaterialButton(
                onPressed: _makeFav,
                shape: CircleBorder(),
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: currentIsFav()),

            //play_button
            MaterialButton(
                onPressed: _playAya,
                shape: CircleBorder(),
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: _control),

            //love button
            MaterialButton(
                onPressed: _shareContent,
                shape: CircleBorder(),
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.share,
                  size: 25,
                  color: ayaDetailBb,
                )),
          ],
        ),
      ),
    );
  }

  _playAya() {

    internetConnection().then((connection) {
      if (connection) {
        if (!play) {
          Fluttertoast.showToast(msg: "يرجى الانتظار جاري التشغيل");
          _control = Padding(
            padding: const EdgeInsets.all(7),
            child: CircularProgressIndicator(),
          );
          playPause();
          favList[current].getAudioUrl("ar.alafasy").then((url) {
            setState(() {
              _control = puseAr;
            });
            int i = 0; //counter for ayat audios fiels;
            advancedPlayer.play(url[i]);
            advancedPlayer.onPlayerCompletion.listen((event) {
              i++;
              if (i < url.length) {
                advancedPlayer.play(url[i]);
                _control = puseAr;
              } else{
                playPause();
                _control = playAr;
              }

              //print("i = $i and  leng = ${url.length.toString()}");
            });

          });
        } else {
          playPause();
          advancedPlayer.stop().then((v) {
            setState(() {
              _control = playAr;
            });
          });
        }
      } else {
        Fluttertoast.showToast(msg: "يرجى الاتصال بالانترنت ومعاودة المحاولة");
      }
    });
  }

  playPause() => setState(() {
        play = !play;
//        _control == playAr ? _control = puseAr :  _control = playAr;
      });

  Widget currentIsFav() {
    if (favList.isNotEmpty) {
      setState(() {
        favList[current].isFav == 1
            ? heart = Icons.favorite
            : heart = Icons.favorite_border;
      });
    }

    return Icon(heart, size: 25, color: ayaDetailBb);
  }

  Future<bool> internetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
      return false;
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }

  void _makeFav() {
    favList[current].updateFave();
    setState(() {
      if (favList[current].isFav == 1) {
        Fluttertoast.showToast(msg: "تمت الاضافة الي المفضلة");
        heart = Icons.favorite;
      } else {
        Fluttertoast.showToast(msg: "تمت الإزالة من المفضلة");
        heart = Icons.favorite_border;
      }
    });
  }

  _shareContent() {
    Fav a = favList[current];
    Share.share(a.text + "\n #${a.swra} (${a.index})");
  }
}
