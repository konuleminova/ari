import 'package:ari/ui/provider/change_language/change_language_action.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChangeLangState {
  final String lang;

  ChangeLangState({this.lang});

  ChangeLangState copyWith({String lang}) {
    return ChangeLangState(lang: lang ?? this.lang);
  }
}

final ChangeLangState initState = ChangeLangState(
    lang: SpUtil.getString(SpUtil.lang).isNotEmpty
        ? SpUtil.getString(SpUtil.lang)
        : 'az');

//reducer
ChangeLangState _reducer(ChangeLangState state, ChangeLangAction action) {
  if (action is ChangeLangAction) {
    SpUtil.putString(SpUtil.lang, action.langugae).then((value) {
      print('LANG VALUE ${value}');
    });
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
