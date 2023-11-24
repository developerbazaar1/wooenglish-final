import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';

class HttpMethod {
  static final HttpMethod instance = HttpMethod._();
  HttpMethod._();
  Future<http.Response?> postRequest({
    required String url,
    String endValue = "",
    required Map<String, dynamic> bodyParams,
    Function (int)? getResponseCode


  }) async {
    String token=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnToken);

    if (kDebugMode) print("CALLING:: $url$endValue");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (kDebugMode) print("TOKEN:: $token");
    if (await CM.internetConnectionCheckerMethod()) {
      try {

        http.Response? response =
            await http.post(Uri.parse(url), body: bodyParams, headers: {
          ApiKey.accept: ApiKey.applicationJson,
              ApiKey.authorization: '${ApiKey.bearer} $token',
        });
        getResponseCode?.call(response.statusCode??0);
        if (kDebugMode) print("CALLING:: ${response.body}");
        return response;
      } catch (e) {
        getResponseCode?.call(400);
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      CM.noInternet();
      return null;
    }
  }

  Future<http.Response?> getRequest({
    required String url,
  }) async {
    if (kDebugMode) print("CALLING:: $url");
    if (await CM.internetConnectionCheckerMethod()) {
      String token = await DatabaseHelper.databaseHelperInstance
              .getParticularData(key: DatabaseConst.columnToken);
      try {
        http.Response? response = await http.get(
          Uri.parse(url),
          headers: {
            ApiKey.authorization: '${ApiKey.bearer} $token',
          },
        );
        if (kDebugMode) print("CALLING:: ${response.body}");
        if (kDebugMode) print("TOKEN:: $token");
        return response;
      } catch (e) {
        CM.error();
        return null;
      }
    } else {
      return null;
    }
  }

  Future<http.Response?> getRequestForParams({
    required Map<String, dynamic>   queryParameters,
    required String baseUriForParams,
    required String endPointUri,
  }) async {
    if (await CM.internetConnectionCheckerMethod()) {
      String token = await DatabaseHelper.databaseHelperInstance
              .getParticularData(key: DatabaseConst.columnToken);
      try {
        Uri uri = Uri.http(
          baseUriForParams,
          endPointUri,
          queryParameters,
        );
        if (kDebugMode) print("CALLING:: $uri");
        if (kDebugMode) print("QUERYPARAMETERS:: $queryParameters");
        if (kDebugMode) print("TOKEN::  $token");
        http.Response? response = await http.get(
          uri,
          headers: {
            ApiKey.authorization: '${ApiKey.bearer} $token',
          },
        );
        if (kDebugMode) print("CALLING:: ${response.body}");
        // ignore: unnecessary_null_comparison
        if (response != null) {
          return response;
        } else {
          return null;
        }
      } catch (e) {
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      return null;
    }
  }

  Future<http.Response?> deleteRequest({
    required String url,
    required Map<String, dynamic> bodyParams,
    Map<String, String>? token,
  }) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        http.Response? response =
            await http.delete(Uri.parse(url), body: bodyParams, headers: token);
        if (kDebugMode) print("CALLING:: ${response.body}");
        return response;
      } catch (e) {
        if (kDebugMode) print("ERROR:: $e");
        CM.error();
        return null;
      }
    } else {
      CM.noInternet();
      return null;
    }
  }

  Future<http.Response?> updateMultipartRequest({
    File? image,
    required String url,
    required String multipartRequestType /* POST or GET */,
    required Map<String, dynamic> bodyParams,
    required String token,
    required String imageKey,
  }) async {
    if (kDebugMode) print("CALLING:: $url");
    if (kDebugMode) print("BODYPARAMS:: $bodyParams");
    http.Response? res;
    if (await CM.internetConnectionCheckerMethod()) {
      if (image != null) {
        try {
          http.MultipartRequest multipartRequest =
              http.MultipartRequest(multipartRequestType, Uri.parse(url));
          bodyParams.forEach((key, value) {
            multipartRequest.fields[key] = value;
          });
          multipartRequest.headers['Authorization'] = token;
          multipartRequest.files.add(
            http.MultipartFile.fromBytes(
              imageKey,
              image.readAsBytesSync(),
              filename: image.uri.pathSegments.last,
            ),
          );

          http.StreamedResponse response = await multipartRequest.send();
          res = await http.Response.fromStream(response);
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
          CM.error();
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          return res;
        } else {
          return null;
        }
      } else {
        try {
          res = await http.post(
            Uri.parse(url),
            body: bodyParams,
            headers: {"authorization": token},
          );
        } catch (e) {
          if (kDebugMode) print("ERROR:: $e");
          CM.error();
          return null;
        }
        // ignore: unnecessary_null_comparison
        if (res != null) {
          if (kDebugMode) print("CALLING:: ${res.body}");
          return res;
        } else {
          return null;
        }
      }
    } else {
      CM.noInternet();
      return null;
    }
  }
}
