//import 'package:ari/services/provider/provider.dart';
//import 'package:ari/ui/provider_components/component_b.dart';
//import 'package:ari/ui/provider_components/counter_action.dart';
//import 'package:ari/ui/provider_components/counter_state.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter_hooks/flutter_hooks.dart';
//
//class ComponentA extends HookWidget {
//  @override
//  Widget build(BuildContext context) {
//    final CounterStore store = useCounterStore();
//    useProviderRegistration(store);
//
//
//
//
//    // TODO: implement build
//    return Center(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          Text(
//            store.counter.toString(),
//          ),
//          Text(
//            store.owner,
//          ),
//          RaisedButton(
//            onPressed: () {
//              store.setCounter(store.counter + 1);
//            },
//            child: Text('Increment counter'),
//          ),
//          RaisedButton(
//            onPressed: () {
//              store.setCounter(store.counter - 1);
//            },
//            child: Text('Decrement counter'),
//          ),
//          RaisedButton(
//            onPressed: () {
//              store.setOwner('Konull');
//            },
//            child: Text('Change owner'),
//          ),
//          //Provider ile register edir map-e keye yazir counterStoru
//          Provider<CounterStore>(
//              value: store, child: ComponentB())
//        ],
//      ),
//    );
//  }
//}
