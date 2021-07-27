import 'package:flutter/material.dart';
class Constants{
  static Map<int,Color> myMap = {
    50:Color.fromRGBO(21, 28, 38, 0.1),
    100:Color.fromRGBO(21, 28, 38, 0.2),
    200:Color.fromRGBO(21, 28, 38, 0.3),
    300:Color.fromRGBO(21, 28, 38, 0.4),
    400:Color.fromRGBO(21, 28, 38, 0.5),
    500:Color.fromRGBO(21, 28, 38, 0.6),
    600:Color.fromRGBO(21, 28, 38, 0.7),
    700:Color.fromRGBO(21, 28, 38, 0.8),
    800:Color.fromRGBO(21, 28, 38, 0.9),
    900:Color.fromRGBO(21, 28, 38, 1.0),
  };
  static MaterialColor color  = MaterialColor(0xFF151C26,myMap);

  static String apiKey = '8c70c7cadc8cd783f8d15559b562d5da';
}