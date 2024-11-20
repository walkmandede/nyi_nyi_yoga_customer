
// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:kmdmobilehybrid/utils/api/api_response_model.dart';

class ApiService {
  String baseUrl = "http://yoga.activemyanmarstore.com/api";

  Future<bool> checkInternet() async {
    if (kIsWeb) {
      return true;
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
      return false;
    }
  }

  String convertNetworkImage({required String orgPath}) {
    return ApiService().baseUrl.replaceAll("api/", "api") + orgPath;
  }

  // Response convertHttpResponseToGetResponse({required http.Response response}) {
  //   try {
  //     return Response(
  //       statusCode: response.statusCode,
  //       body: jsonDecode(response.body),
  //       bodyString: response.body,
  //       headers: response.headers,
  //     );
  //   } catch (e) {
  //     return Response(
  //       statusCode: response.statusCode,
  //       body: null,
  //       bodyString: response.body,
  //       headers: response.headers,
  //     );
  //   }
  // }

  ApiResponse validateResponse({required http.Response? response}){
    ApiResponse result = ApiResponse.getInstance();
    result.isSuccess = false;

    if(response==null){
      return result;
    }

    try{
      Map<String,dynamic> data = jsonDecode(response.body);
      if(data["status"] == "success"){
        result.isSuccess = true;
      }
      result.statusCode = response.statusCode;
      result.bodyData = data;
      result.bodyString = response.body;
      result.message = data["message"].toString();
    }catch(_){}
    return result;
  }

  Future<Response?> get({
      required String endPoint,
      bool xBaseUrlIncluded = true
  }) async {
    final xHasInternet = await checkInternet();
    if (xHasInternet) {
      final response = await http.get(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
        },
      );

      return response;
    } else {
      return null;
    }
  }

  Future<Response?> post({
    required String endPoint,
    Map<String, dynamic> data = const {},
    bool xBaseUrlIncluded = true
  }) async {
    final xHasInternet = await checkInternet();
    if (xHasInternet) {

      final response = await http.post(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$endPoint" : endPoint),
        body: jsonEncode(data),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
        },
      );

      return response;
    } else {
      return null;
    }
  }
}
