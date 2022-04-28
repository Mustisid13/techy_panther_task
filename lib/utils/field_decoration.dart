// decoration applied to form fields
import 'package:flutter/material.dart';

InputDecoration fieldDecoration(String hintText,IconData icon){
  return InputDecoration(
      icon: Icon(icon),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      border: const OutlineInputBorder(),
      contentPadding: const EdgeInsets.all(4));
}