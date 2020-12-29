import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/ui/provider/checkout/checkout_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CheckoutState {
  final String address;
  final String coords;
  final String additionalAddress;
  var isInPolygon;

  CheckoutState(
      {this.address, this.coords, this.isInPolygon, this.additionalAddress});

  CheckoutState copyWith(
      {String address,
      String coords,
      bool isInPolygon,
      String additionalAddress}) {
    return CheckoutState(
        address: address ?? this.address,
        coords: coords ?? this.coords,
        isInPolygon: isInPolygon ?? this.isInPolygon,
        additionalAddress: additionalAddress ?? this.additionalAddress);
  }
}

final CheckoutState initialCheckoutState =
    CheckoutState(address: '', coords: '', isInPolygon: false,additionalAddress: '');

//reducer (copy data from action)

CheckoutState _reducer(CheckoutState state, CheckoutAction action) {
  if (action is CheckoutAction) {
    return state.copyWith(
      address: action.address,
      coords: action.coords,
      isInPolygon: action.isInPolygon,
      additionalAddress: action.additionalAddress
    );
  }

  return state;
}

//Store data from reducer

Store<CheckoutState, CheckoutAction> useCheckoutStore() {
  final store = useReducer(_reducer, initialState: initialCheckoutState);
  return store;
}
