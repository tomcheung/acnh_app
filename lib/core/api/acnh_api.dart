import 'package:http/http.dart' as http;

import '../config.dart';
import '../firebase_service.dart';
import '../provider/account_provider.dart';

enum Method {
  get,
  post,
  delete,
  put,
  patch
}

Future<http.Response> request(Method method, String endpoint,
    {dynamic body, AccountProvider accountProvider}) async {
  final idToken = await FirebaseService.instance.getInstanceId();
  var headers = {
    'X-userId': accountProvider.currentUser.userId,
    'X-idToken': idToken,
//  'X-appversion':
  };

  final url = '${env.serverRoot}/$endpoint';

  switch (method) {
    case Method.post:
      return http.post(url, body: body, headers: headers);
    case Method.get:
      return http.get(url, headers: headers);
    case Method.delete:
      return http.delete(url, headers: headers);
    case Method.put:
      return http.put(url, body: body, headers: headers);
    case Method.patch:
      return http.patch(url, body: body, headers: headers);
    default:
      return null;
  }
}