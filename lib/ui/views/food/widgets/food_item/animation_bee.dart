import 'package:ari/business_logic/models/food.dart';
import 'package:ari/ui/views/food/widgets/food_item/food_item.dart';
import 'package:flutter/material.dart';

import 'food_item_expanded.dart';

class AnimationBeeWidget extends StatefulWidget {
  Widget child;
  var addtoCartCallback;
  var dropDownCallBack;
   Food food;

  AnimationBeeWidget(
      {this.child, this.food, this.addtoCartCallback, this.dropDownCallBack});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AnimationBee();
  }
}

class _AnimationBee extends State<AnimationBeeWidget>
    with TickerProviderStateMixin {
  AlignmentGeometryTween _tween;

  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        AnimatedCrossFade(
          duration: Duration(seconds: 1),
          firstChild: FoodItem(
            addtoCartCallBack: (v) {
              widget.addtoCartCallback(v);
              _play();
            },
            item: widget.food,
          ),
          secondChild: FoodItemExpanded(
            addtoCartCallBack: widget.addtoCartCallback,
            food: widget.food,
            dropDownCallBack: widget.dropDownCallBack,
          ),
          crossFadeState: widget.food.selected
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
        AlignTransition(
          alignment: _tween.animate(animationController),
          child: Image.asset(
            'assets/images/curyer.png',
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _tween = AlignmentGeometryTween(
      begin: Alignment.topLeft,
      end: Alignment.topRight,
    );
  }

  TickerFuture _play() {
    animationController.reset();
    return animationController.animateTo(
      1.0,
      curve: Curves.easeInOut,
    );
  }
}
