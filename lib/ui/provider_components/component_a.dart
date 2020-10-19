import 'package:ari/services/provider/provider.dart';
import 'package:ari/ui/provider_components/component_b.dart';
import 'package:ari/ui/provider_components/counter_action.dart';
import 'package:ari/ui/provider_components/counter_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ComponentA extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final Store<CounterState, CounterAction> counterStore = useCounterStore();
    useProviderRegistration(counterStore);
    useProviderRegistration(counterStore, 'Store_2');



    // TODO: implement build
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            counterStore.state.counter.toString(),
          ),
          Text(
            counterStore.state.owner,
          ),
          RaisedButton(
            onPressed: () {
              counterStore.dispatch(
                  ChangeCounterAction(counterStore.state.counter + 1));
            },
            child: Text('Increment counter'),
          ),
          RaisedButton(
            onPressed: () {
              counterStore.dispatch(
                  ChangeCounterAction(counterStore.state.counter - 1));
            },
            child: Text('Decrement counter'),
          ),
          RaisedButton(
            onPressed: () {
              counterStore.dispatch(ChangeOwnerAction('Konul Eminova'));
            },
            child: Text('Change owner'),
          ),
          //Provider ile register edir map-e keye yazir counterStoru
          Provider<Store<CounterState, CounterAction>>(
              value: counterStore, child: ComponentB())
        ],
      ),
    );
  }
}
