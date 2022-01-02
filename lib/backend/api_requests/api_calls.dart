import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class GetCountriesCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'getCountries',
      apiUrl: 'https://api.countrystatecity.in/v1/countries',
      callType: ApiCallType.GET,
      headers: {
        'X-CSCAPI-KEY': 'API_KEY',
      },
      params: {},
      returnBody: true,
    );
  }
}
