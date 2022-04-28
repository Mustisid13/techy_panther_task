import 'package:flutter/material.dart';

void showSnackBar(String message,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(message)
  ));
}