import 'package:flutter/material.dart';

void navigateTo(context,widget) => Navigator.of(context).push(MaterialPageRoute(builder: (_){
  return widget;
}));