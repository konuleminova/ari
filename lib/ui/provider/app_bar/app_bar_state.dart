import 'package:ari/services/hooks/use_callback.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppBarStrore {
  final int index;
  final String message;
  final Function(String) setMessage;
  final Function(int) setIndex;

  AppBarStrore({this.index, this.message, this.setIndex, this.setMessage});
}

AppBarStrore useAppBarStore() {
  final index = useState<int>(0);
  final message = useState<String>('');

  final setIndex = useCallback((int value) {
    index.value = value;
  }, []);
  final setMessage = useCallback((String value) {
    message.value = value;
  }, []);

  return AppBarStrore(
      index: index.value,
      message: message.value,
      setIndex: setIndex,
      setMessage: setMessage);
}
