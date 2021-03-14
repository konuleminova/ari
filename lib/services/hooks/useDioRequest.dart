import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/ui/provider/change_language/change_language_state.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<T> useDioRequest<T>(DioConfig<T> config) {
  final langStore = getLanguageStore();

  final ValueNotifier<ApiResponse<T>> _state =
      useState<ApiResponse<T>>(ApiResponse.initial());
  Dio dio = useMemoized(() => Dio());
  useEffect(() {
    bool isCancel = false;
    CancelToken cancelToken;
    if (config != null) {
      _state.value = ApiResponse.loading();
      cancelToken = CancelToken();
      final queryParams = config.queryParamaters ?? {};
      queryParams['lang'] =
          langStore.state.lang ?? SpUtil.getString(SpUtil.lang);
      print('REQUESTED URL: ${config.path}&lang=${langStore.state.lang}');
      dio
          .request(config.path,
              data: config.data,
              queryParameters: queryParams,
              options: config.options,
              onSendProgress: config.onSendProgress,
              onReceiveProgress: config.onReceiveProgress,
              cancelToken: cancelToken)
          .then((value) {
        if (!isCancel) {
          _state.value = ApiResponse.completed(config.transformResponse(value));
        }
      }).catchError((error) {
        if (!isCancel) {
            if (DioErrorType.DEFAULT == error?.type) {
              _state.value = ApiResponse.error(
                  AppException(message: "No internet Connection"));
            } else
            _state.value =
                ApiResponse.error(AppException(message: error.toString()));
        }
      });
    } else {
      _state.value = ApiResponse.initial();
    }
    return () {
      isCancel = true;
      if (cancelToken != null) {
        cancelToken.cancel('Request Cancelled');
        cancelToken = null;
      }
    };
  }, [config, langStore.state.lang]);
  //print('STATEB VALUE ${_state.value}');
  return _state.value;
}
