import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _controller =
        VideoPlayerController.asset('assets/videos/splash_animation.mp4')
          ..initialize().then((_) {
            setState(() {});
            _controller.play().then((value) {
              _controller.addListener(() {
                if (!_controller.value.isPlaying) {
                  if (context != null) {
                    SpUtil.putString(SpUtil.isFromMap, '').then((value){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => InitPage()));
                    });

                  }
                }
              });
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          //FURTHER IMPLEMENTATION
        ],
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
