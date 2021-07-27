import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelPer{
  static Dio dio;

 static void init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.themoviedb.org/3/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
  @required String path,
  @required Map<String,dynamic> query,
})async{
  return await dio.get(
     path,
     queryParameters: query,
   );
  }
}