import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/ui/provider_components/counter_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CounterStore {
  final int counter;
  final void Function(int) setCounter;
  final String owner;
  final void Function(String) setOwner;

  CounterStore({
    this.counter,
    this.setCounter,
    this.owner,
    this.setOwner
  });
}


CounterStore useCounterStore() {
  final counter = useState(0);
  final owner = useState('Ali');

  final setCounter = useCallback((int value) {
    counter.value = value;
  }, []);

  final setOwner = useCallback((String value) {
    owner.value = value;
  }, []);

  return CounterStore(
    counter: counter.value,
    owner: owner.value,
    setCounter: setCounter,
    setOwner: setOwner
  );
}



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

//Store<CounterState, CounterAction> useCounterStore() {
//  Store<CounterState, CounterAction> store =
//      useReducer(_reducer, initialState: initialCounterState);
//  return store;
//}
