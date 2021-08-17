import 'dart:async';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  int _score = 0;
  bool _buttonEnabled = true;
  Color _estadoColor = Colors.black;
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    var option = next(0, 2);
    var randomItem = "";
    if (option == 0) {
      print("change to noun");
      randomItem = (nouns.toList()..shuffle()).first;
      setState(() {
        _theState = randomItem;
      });

      _actualWordType = 0;
    } else {
      print("change to adjective");
      randomItem = (adjectives.toList()..shuffle()).first;
      setState(() {
        _theState = randomItem;
      });
      _actualWordType = 1;
    }
  }

  void _onPressed(int selection) {
    _buttonEnabled = false;
    if (_actualWordType == selection) {
      setState(() {
        _theState = "correct!";
        _estadoColor = Colors.green;
        _score += 1;
        Timer(Duration(seconds: 3), () {
          setRandomWord();
          _estadoColor = Colors.black;
          _buttonEnabled = true;
        });
      });
    } else {
      _buttonEnabled = false;
      setState(() {
        _theState = "Wrong!";
        if (_score > 0) {
          _score -= 1;
        }

        _estadoColor = Colors.red;
        Timer(Duration(seconds: 3), () {
          setRandomWord();
          _estadoColor = Colors.black;
          _buttonEnabled = true;
        });
      });
    }
  }

  void _onReset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => RandomWords(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Random Words"),
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text("Score:" + "$_score"),
          ]),
          Text(
            "$_theState",
            style: TextStyle(
              color: _estadoColor,
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, //background color of button
                    side: BorderSide(
                        width: 3, color: Colors.red), //border width and color
                    elevation: 3, //elevation of button
                  ),
                  onPressed: _buttonEnabled ? () => _onPressed(0) : null,
                  child: Text("Noun")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent, //background color of button
                    side: BorderSide(
                        width: 3, color: Colors.red), //border width and color
                    elevation: 3, //elevation of button
                  ),
                  onPressed: _buttonEnabled ? () => _onPressed(1) : null,
                  child: Text("Adjective"))
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                iconSize: 60,
                onPressed: () => _onReset(),
                icon: Icon(Icons.restart_alt))
          ])
        ]));
  }
}
