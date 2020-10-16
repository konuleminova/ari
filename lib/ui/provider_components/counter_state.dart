import 'package:ari/ui/provider_components/counter_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CounterState {
  final int counter;
  final String owner;

  CounterState({this.counter, this.owner});

  CounterState copyWith({int counter, String owner}) {
    return CounterState(
        counter: counter ?? this.counter, owner: owner ?? this.owner);
  }
}

final CounterState initialCounterState =
    CounterState(counter: 0, owner: 'Ali Rashidov');

CounterState _reducer(CounterState state, CounterAction action) {
  if (action is ChangeCounterAction) {
    return state.copyWith(counter: action.counter);
  }
  if (action is ChangeOwnerAction) {
    return state.copyWith(owner: action.owner);
  }
  return state;
}

Store<CounterState, CounterAction> useCounterStore() {
  Store<CounterState, CounterAction> store =
      useReducer(_reducer, initialState: initialCounterState);
  return store;
}
