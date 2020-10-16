part of 'provider.dart';

class _ProviderInjector {
  static _ProviderInjector _instance;
  final Map<String, dynamic> _providers = <String, dynamic>{};

  static _ProviderInjector getInstance() {
    if (_instance == null) {
      _instance = _ProviderInjector();
    }
    return _instance;
  }

  String _makeKey<T>(T type, [String key]) =>
      '${type.toString()}::${key ?? 'default'}';

  //(bu hisseni izzah olunacaq)
  bool _hasKey(String key) {
    return this._providers.containsKey(key);
  }

  void registerOrUpdateWithValue<T>(T value) {
    String key = _makeKey(T);
    this._providers[key] = value;
  }

  void unRegisterProvider<T>() {
    String key = _makeKey(T);
    if (this._hasKey(key)) {
      this._providers.remove(key);
    }
  }

  T getProviderValue<T>() {
    String key = _makeKey(T);
    if (!_hasKey(key)) {
      throw Exception('Rovider can not find ${key}');
    }
    return this._providers[key];
  }
}
