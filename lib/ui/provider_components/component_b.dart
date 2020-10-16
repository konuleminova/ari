import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/provider/provider.dart';
import 'package:ari/ui/provider_components/counter_action.dart';
import 'package:ari/ui/provider_components/counter_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ComponentB extends HookWidget {
  @override
  Widget build(BuildContext context) {
    Store<CounterState, CounterAction> store =
        useProvider<Store<CounterState, CounterAction>>();
    //bu hissede map-e yazilmish keye esasen store-u qaytarir.

//    final changeCounterAction = useCallback(() {
//      store.dispatch(ChangeCounterAction(store.state.counter + 1));
//    }, []);(bu hisseni izzah olunacaq)

    // TODO: implement build
    return Column(
      children: <Widget>[
        //Text(store.state.counter.toString()),
        RaisedButton(
            child: Text('B component change counter'),
            onPressed: () {
              store.dispatch(ChangeCounterAction(store.state.counter + 1));
            })
      ],
    );
  }
}
