import 'package:ari/business_logic/models/food.dart';
import 'package:ari/ui/views/food/widgets/food_item/food_item.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
              _play();
              animationController.addListener(() {
                print('ANIATION CONTROLLER ${animationController.value}');
                if (animationController.value > 0.09) {
                 // animationController.removeListener(() { });
                  widget.addtoCartCallback(v);
                }
              });
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
//        Positioned(
//          bottom: 60.toHeight,
//          left: 0,
//          child: ,
//        )
        AlignTransition(
          alignment: _tween.animate(animationController),
          child: Image.asset(
            'assets/images/curyer.png',
            width: 40,
            height: 40,
          ),
        )
      ],
    );
  }

  @override
  dispose() {
    print('DISPOSE');
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print('INIT STATE');
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _tween = AlignmentGeometryTween(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
    );
  }

  TickerFuture _play() {
   // animationController.reset();
    return animationController.animateTo(
      1.0,
      curve: Curves.easeInOut,
    );
  }
}
