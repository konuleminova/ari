part of 'provider.dart';

final providerInstanece = useMemoized<_ProviderInjector>(
    () => _ProviderInjector.getInstance(), const []);

T useProvider<T>() {
  return providerInstanece.getProviderValue();
}

void useProviderRegistration<T>(T value) {
  useEffect(() {
    return () {
      providerInstanece.unRegisterProvider();
    };
  }, []);
  providerInstanece.registerOrUpdateWithValue<T>(value);
}



