import 'package:ari/business_logic/models/food.dart';
import 'package:ari/services/services/status_service.dart';
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
  bool working;

  AnimationBee(
      {this.food, this.addtoCartCallback, this.dropDownCallBack, this.working,});

  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    var isBeeStartAnimate = useState<bool>(false);
    var isBeeWithBasket = useState<bool>(false);
    animationController =
        useAnimationController(duration: Duration(seconds: 3));
    _tween = AlignmentGeometryTween(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
    );
    // TODO: implement build
    return Stack(
      children: [
        Align(
          child: AnimatedCrossFade(
            duration: Duration(milliseconds: 600),
            firstChild: FoodItem(
              addtoCartCallBack: (v) {
                if(working) {
                  _play();
                  animationController.addListener(() {
                    if (animationController.value == 0) {
                      isBeeStartAnimate.value = true;
                      v.selected = false;
                    } else if (animationController.value > 0.99) {
                      isBeeStartAnimate.value = false;
                      //v.selected = true;
                     // addtoCartCallback(v);
                    }
                    if (animationController.value > 0.33) {
                      isBeeWithBasket.value = true;
                      v.expanded=true;
                      v.selected=true;
                      addtoCartCallback(v);
                    }
                  });
                }else{
                  v.selected=false;
                  addtoCartCallback(v);
                }
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
          alignment: Alignment.topLeft,
        ),
        Positioned(
         top: food.information.isEmpty?38.toHeight:58.toHeight,
          left: 0,
          right: 0,
          child: isBeeStartAnimate.value
              ? AlignTransition(
                  alignment: _tween.animate(animationController),
                  child: Container(
                    width: 50.toWidth,
                    height: 50.toWidth,
                    child: Image.asset(
                      isBeeWithBasket.value
                          ? 'assets/images/ari_with_basket.png'
                          : 'assets/images/bee.png',
                    ),
                    // color: Colors.red,
                  ))
              : SizedBox(),
        )
      ],
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
