import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/ui/provider_components/checkout_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CheckoutState {
  final String address;
  final String coords;
  final isInPolygon;

  CheckoutState({this.address, this.coords, this.isInPolygon});

  CheckoutState copyWith({String address, String coords, bool isInPolygon}) {
    return CheckoutState(
        address: address ?? this.address,
        coords: coords ?? this.coords,
        isInPolygon: isInPolygon ?? this.isInPolygon);
  }
}

final CheckoutState initialCheckoutState =
    CheckoutState(address: '', coords: '', isInPolygon: false);

//reducer (copy data from action)

CheckoutState _reducer(CheckoutState state, CheckoutAction action) {
  if (action is CheckoutAction) {
    return state.copyWith(
        address: action.address,
        coords: action.coords,
        isInPolygon: action.isInPolygon);
  }

  return state;
}
//Store data from reducer

Store<CheckoutState, CheckoutAction> useCheckoutStore() {
  final store = useReducer(_reducer, initialState: initialCheckoutState);
  return store;
}
