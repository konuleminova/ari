import 'package:ari/ui/provider/change_language/change_language_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChangeLangState {
  final String lang;

  ChangeLangState({this.lang});

  ChangeLangState copyWith({String lang}) {
    return ChangeLangState(lang: lang ?? this.lang);
  }
}

final ChangeLangState initState = ChangeLangState(lang: 'az');

//reducer
ChangeLangState _reducer(ChangeLangState state, ChangeLangAction action) {
  if (action is ChangeLangAction) {
    return state.copyWith(lang: action.langugae);
  }
  return state;
}
//store

Store<ChangeLangState, ChangeLangAction> useChangeLangStore() {
  Store<ChangeLangState, ChangeLangAction> store =
      useReducer(_reducer, initialState: initState);
  return store;
}
