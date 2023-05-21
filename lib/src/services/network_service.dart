import 'dart:convert';
import 'package:http/http.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "";
  static String SERVER_PRODUCTION = "";

  static Map<String, String> getHeaders() {
    Map<String, String> headers = {};
    return headers;
  }

  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    var response = await get(uri, headers: getHeaders());
    print(response.statusCode);
    print(response.headers);
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api);
    var response = await post(uri, headers: getHeaders(), body: params);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> MULTIPART(
      String api, String filePath, Map<String, String> params) async {
    var uri = Uri.http(getServer(), api);
    var request = MultipartRequest("POST", uri);

    request.headers.addAll(getHeaders());
    request.fields.addAll(params);
    request.files.add(await MultipartFile.fromPath("image", filePath));

    var res = await request.send();
    print(res.statusCode);
    print(res.request?.url);
    if(res.statusCode == 200) {
      return res.reasonPhrase;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response =
    await put(uri, headers: getHeaders(), body: jsonEncode(params));
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api); // http or https
    var response =
    await patch(uri, headers: getHeaders(), body: jsonEncode(params));
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(getServer(), api, params); // http or https
    var response = await delete(uri, headers: getHeaders());
    if (response.statusCode == 200) return response.body;
    return null;
  }

  /* Http Apis */
  static String API_LOGIN = "/api/login";

  /* Http Params */
  static Map<String, dynamic> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }
}
