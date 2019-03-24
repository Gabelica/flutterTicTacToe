import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';

class GameSettings extends StatefulWidget {
  // This widget is the root of application.
  @override
  State<StatefulWidget> createState() {
    return _GameSettingsState();
  }
}

class _GameSettingsState extends State<GameSettings> {
  int _radioDifficulty = 0;
  var isVisible = true;

//sets computer difficulty
  void _setNewDifficulty(int value) {
    setState(() {
      _radioDifficulty = value;
      globalDifficulty = _radioDifficulty;
    });
    print(_radioDifficulty);
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "  Play with computer",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Checkbox(
                      value: playWithComp,
                      //activeColor: Colors.black12,
                      checkColor: Colors.orange,
                      onChanged: (bool value) {
                        setState(() {
                          playWithComp = !playWithComp;
                          isVisible = playWithComp;
                          print(value);
                        });
                      })
                ],
              ),
              Row(
                children: <Widget>[
                  Container(
                    child: Text(" "),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Computer difficulty:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  )
                ],
              ),
              Visibility(
                maintainSemantics: true,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioDifficulty,
                      onChanged: _setNewDifficulty,
                    ),
                    Radio(
                      value: 1,
                      groupValue: _radioDifficulty,
                      onChanged: _setNewDifficulty,
                    ),
                    Radio(
                      value: 2,
                      groupValue: _radioDifficulty,
                      onChanged: _setNewDifficulty,
                    )
                  ],
                ),
              ),
              Visibility(
                maintainSemantics: true,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: isVisible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("EASY"),
                    Text("MEDIUM"),
                    Text("HARD"),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
