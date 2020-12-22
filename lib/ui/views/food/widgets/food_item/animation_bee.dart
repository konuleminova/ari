import 'package:flutter/material.dart';

AnimationController animationController;

class AnimationBeeWidget extends StatefulWidget {
  Widget child;

  AnimationBeeWidget({this.child});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimationBee();
  }
}

class _AnimationBee extends State<AnimationBeeWidget>
    with SingleTickerProviderStateMixin {
  Animation<Offset> offset;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        SlideTransition(
          child: Image.asset('assets/images/curyer.png',width: 40,height: 40,),
          position: offset,
        ),
        widget.child
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset.infinite)
        .animate(animationController);
  }
}

void onTapAnimate() {
  if (animationController != null) {
    animationController.forward();
  }
}
