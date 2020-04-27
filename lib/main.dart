import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappadaya/model/Sura.dart';
import 'package:flutterappadaya/views/bg.dart';
import 'package:flutterappadaya/views/carousel.dart';

typedef void OnError(Exception exception);

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();
  String localFilePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (kIsWeb) {
      // Calls to Platform.isIOS fails on web
      return;
    }
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adayaa Quran',
      home:  Stack(
          children: <Widget>[
            Bg(),
            DoaaCarousel(),
          ],
        ),
    );
  }
}
