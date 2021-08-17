import 'package:flutter/material.dart';
import 'random_words.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      title: "RandomWords",
      home: RandomWords()));
}
