import 'package:ari/services/provider/provider.dart';
import 'package:ari/ui/provider/app_bar/app_bar_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppBarState {
  final int index;
  final String message;
  final UniqueKey uniqueKey;

  AppBarState({this.index, this.message, this.uniqueKey});

  AppBarState copyWith({String message, int index, UniqueKey uniqueKey}) {
    return AppBarState(message: message, index: index, uniqueKey: uniqueKey);
  }
}

//init state
final AppBarState initState =
    AppBarState(message: '', index: 0, uniqueKey: new UniqueKey());

//reducer
AppBarState _reducer(AppBarState state, AppBarAction action) {
  if (action is AppBarAction) {
    return state.copyWith(
        message: action.message,
        index: action.index,
        uniqueKey: action.uniqueKey);
  }
  return state;
}
//store

Store<AppBarState, AppBarAction> useAppBarStore() {
  Store<AppBarState, AppBarAction> store =
      useReducer(_reducer, initialState: initState);
  return store;
}

void registerAppBarStore() {
  useProviderRegistration(useAppBarStore());
}

Store<AppBarState, AppBarAction> getAppBarStore() {
  return useProvider<Store<AppBarState, AppBarAction>>();
}
