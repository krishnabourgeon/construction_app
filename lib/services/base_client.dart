import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:construction_app/services/app_config.dart';
import 'package:construction_app/services/helpers.dart';
import 'package:construction_app/services/shared_preference_helper.dart';
import 'package:http/http.dart' as http;
import 'app_exceptions.dart';
import 'package:async/async.dart';

class BaseClient {
  static final BaseClient _instance = BaseClient._internal();
  factory BaseClient() => _instance;
  BaseClient._internal();
  static const int timeDuration = 20;
  static Future<String> get token async {
    return AppConfig.accessToken == null
        ? await SharedPreferenceHelper.getToken()
        : AppConfig.accessToken!;
  }

  static const String _appJson = 'application/json';
  static Map<String, String> commonHeaders = {
    'Content-Type': 'application/json',
    //HttpHeaders.contentTypeHeader: 'application/json',
  };
  //GET METHOD
  static Future<dynamic> get(String api, {Map<String, String>? map}) async {
    String bearerToken = await token;
    String queryString = Uri(queryParameters: map ?? {}).query;
    var uri;
    if (map != null) {
      uri = Uri.parse('${AppConfig.baseUrl}$api?$queryString');
    } else {
      uri = Uri.parse(AppConfig.baseUrl + api);
    }
    bool check = await isInternetAvailable();
    if (check) {
      try {
        var response = await http.get(
          uri,
          headers: {
            HttpHeaders.contentTypeHeader: _appJson,
            HttpHeaders.acceptHeader: _appJson,
            HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
          },
        ).timeout(const Duration(seconds: timeDuration));
        return _processResponse(response);
      } on SocketException {
        return Result.error(FetchDataException('No Internet connection', uri.toString()));
      } on TimeoutException {
        return Result.error(ApiNotRespondingException('API not responded in time', uri.toString()));
      } catch (e) {
        return Result.error(FetchDataException('Unexpected error: $e', uri.toString()));
      }
    } else {
      return Result.error(FetchDataException('No Internet connection', uri?.toString()));
    }
  }

  // GET with a JSON body (non-standard but some APIs require it)
  static Future<dynamic> getWithBody(String api, {required Map<String, dynamic> body}) async {
    String bearerToken = await token;
    var uri = Uri.parse(AppConfig.baseUrl + api);
    bool check = await isInternetAvailable();
    if (check) {
      try {
        var request = http.Request('GET', uri);
        request.headers[HttpHeaders.contentTypeHeader] = _appJson;
        request.headers[HttpHeaders.acceptHeader] = _appJson;
        request.headers[HttpHeaders.authorizationHeader] = 'Bearer $bearerToken';
        request.body = json.encode(body);
        var streamedResponse = await request.send().timeout(const Duration(seconds: timeDuration));
        var response = await http.Response.fromStream(streamedResponse);
        return _processResponse(response);
      } on SocketException {
        return Result.error(FetchDataException('No Internet connection', uri.toString()));
      } on TimeoutException {
        return Result.error(ApiNotRespondingException('API not responded in time', uri.toString()));
      } catch (e) {
        return Result.error(FetchDataException('Unexpected error: $e', uri.toString()));
      }
    } else {
      return Result.error(FetchDataException('No Internet connection', uri.toString()));
    }
  }

  //POST METHOD
  static Future<dynamic> post(String api, {dynamic body}) async {
    String bearerToken = await token;

    var uri = Uri.parse(AppConfig.baseUrl + api);
    bool check = await isInternetAvailable();
    if (check) {
      try {
        var response = await http
            .post(
              uri,
              headers: {
                HttpHeaders.contentTypeHeader: _appJson,
                HttpHeaders.acceptHeader: _appJson,
                HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
              },
              body: body != null ? json.encode(body) : null,
            )
            .timeout(const Duration(seconds: timeDuration));
        // print(response.statusCode);
        // print(response.body);
        return _processResponse(response);
      } on SocketException {
        return Result.error(FetchDataException('No Internet connection', uri.toString()));
      } on TimeoutException {
        return Result.error(ApiNotRespondingException('API not responded in time', uri.toString()));
      } catch (e) {
        return Result.error(FetchDataException('Unexpected error: $e', uri.toString()));
      }
    } else {
      return Result.error(FetchDataException('No Internet connection', uri.toString()));
    }
  }


  static Future<dynamic> delete(String api, {dynamic body}) async {
  String bearerToken = await token;

  var uri = Uri.parse(AppConfig.baseUrl + api);
  bool check = await isInternetAvailable();

  if (check) {
    try {
      var response = await http
          .delete(
            uri,
            headers: {
              HttpHeaders.contentTypeHeader: _appJson,
              HttpHeaders.acceptHeader: _appJson,
              HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
            },
            body: body != null ? json.encode(body) : null,
          )
          .timeout(const Duration(seconds: timeDuration));

      return _processResponse(response);
    } on SocketException {
      return Result.error(FetchDataException('No Internet connection', uri.toString()));
    } on TimeoutException {
      return Result.error(ApiNotRespondingException('API not responded in time', uri.toString()));
    } catch (e) {
      return Result.error(FetchDataException('Unexpected error: $e', uri.toString()));
    }
  } else {
    return Result.error(FetchDataException('No Internet connection', uri.toString()));
  }
}


static Future<dynamic> multipartPost(
  String api, {
  required Map<String, String> fields,
  File? file,
  String fileField = 'file',
}) async {

  String bearerToken = await token;

  var uri = Uri.parse(AppConfig.baseUrl + api);

  bool check = await isInternetAvailable();

  if (check) {
    try {

      var request = http.MultipartRequest(
        'POST',
        uri,
      );

      // Headers
      request.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $bearerToken',
        "Accept": "application/json",
      });

      // Fields
      request.fields.addAll(fields);

      // File
      if (file != null) {

        request.files.add(
          await http.MultipartFile.fromPath(
            fileField,
            file.path,
          ),
        );
      }

      // Send request
      var streamedResponse = await request.send()
          .timeout(const Duration(seconds: timeDuration));

      // Convert response
      var response = await http.Response.fromStream(
        streamedResponse,
      );

      return _processResponse(response);

    } on SocketException {
      return Result.error(FetchDataException('No Internet connection', uri.toString()));
    } on TimeoutException {
      return Result.error(ApiNotRespondingException('API not responded in time', uri.toString()));
    } catch (e) {
      return Result.error(FetchDataException('Unexpected error: $e', uri.toString()));
    }
  } else {
    return Result.error(FetchDataException('No Internet connection', uri.toString()));
  }
}

  static dynamic _processResponse(http.Response response) {
    print(response.body);
    final bodyTrimmed = response.body.trim().toLowerCase();
    final isHtml = bodyTrimmed.startsWith('<!doctype html>') || 
                   bodyTrimmed.startsWith('<html') || 
                   bodyTrimmed.contains('<html') || 
                   bodyTrimmed.contains('<!doctype');

    if (isHtml) {
      return Result.error(FetchDataException(
          'HTML response returned instead of JSON. The server might be redirecting to a login page.',
          response.request!.url.toString()));
    }

    dynamic decoded;
    try {
      decoded = jsonDecode(response.body);
    } catch (e) {
      return Result.error(FetchDataException(
          'Failed to parse JSON response: $e',
          response.request!.url.toString()));
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return Result.value(decoded);
      case 400:
      case 409:
        return Result.error(BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString()));
      case 401:
      case 403:
      case 404:
        return Result.value(decoded);
      case 422:
        return Result.error(BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString()));
      case 500:
      default:
        return Result.error(FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString()));
    }
  }

  static Future<bool> isInternetAvailable({bool enableToast = true}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        if (enableToast) Helpers.successToast("No Internet");
        return false;
      }
    } on SocketException catch (_) {
      if (enableToast) Helpers.successToast("No Internet");
      return false;
    }
  }
}
