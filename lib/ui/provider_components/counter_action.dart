class CounterAction {}

class ChangeCounterAction extends CounterAction {
  final int counter;

  ChangeCounterAction(this.counter);
}

class ChangeOwnerAction extends CounterAction {
  final String owner;

  ChangeOwnerAction(this.owner);
}
