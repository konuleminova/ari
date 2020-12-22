import 'package:ari/business_logic/models/food.dart';
import 'package:ari/ui/views/food/widgets/food_item/food_item.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'food_item_expanded.dart';

class AnimationBee extends HookWidget {
  AlignmentGeometryTween _tween;
  var addtoCartCallback;
  var dropDownCallBack;
  Food food;

  AnimationBee({this.food, this.addtoCartCallback, this.dropDownCallBack});

  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    animationController = useAnimationController(duration: Duration(seconds: 3));
    _tween = AlignmentGeometryTween(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
    );
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
                if (animationController.value > 0.8) {
                  // animationController.removeListener(() { });
                  addtoCartCallback(v);
                }
              });
            },
            item: food,
          ),
          secondChild: FoodItemExpanded(
            addtoCartCallBack: addtoCartCallback,
            food: food,
            dropDownCallBack: dropDownCallBack,
          ),
          crossFadeState: food.selected
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

  TickerFuture _play() {
    // animationController.reset();
    return animationController.animateTo(
      1.0,
      curve: Curves.easeInOut,
    );
  }
}
