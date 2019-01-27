import 'package:flutter/material.dart';

/*
TO DO
change empty field icon
on tap change icon
*/

void main() => runApp(MyApp());
var turn = "+";
void changeTurn() {
  turn == "+" ? turn = "o" : turn = "+";
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: Text("TicTacToe"),
          ),
          body: ListView(
            children: <Widget>[scoreSection, gridSection, turnSection],
          ),
        ));
  }

//show score widget
  Widget scoreSection = Container(
    child: new Score(),
  );

  Widget gridSection = Container(
    child: new Grid(),
  );

//show turn widget
  Widget turnSection = GestureDetector(
    child: Container(
      height: 70.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.cyanAccent,
            width: 5.0), //suround score with theme style border
      ),
      child: Text(
        "Turn : $turn",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
      ),
      alignment: Alignment(0.0, 0.0), // align to center of container
    ),
    onLongPress: null,
  );
}

// keeping track of score
class Score extends StatefulWidget {
  int scoreX;
  int scoreO;

  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  //getter for score variables
  get _scoreX => widget.scoreX;
  get _scoreO => widget.scoreO;

  void resetScore() {
    widget.scoreO = 0;
    widget.scoreX = 0;
  }

  void xWon() {
    widget.scoreX++;
  }

  void oWon() {
    widget.scoreO++;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // get size of screen
    double screenWidth = MediaQuery.of(context).size.width;
    resetScore();
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 5.0), //suround score with theme style border
      ),
      child: Text(
        " $_scoreX  :  $_scoreO ",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
      ),
      alignment: Alignment(0.0, 0.0), // align to center of container
    );
  }
}

class Grid extends StatefulWidget {
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // get size of screen
    double screenWidth = MediaQuery.of(context).size.width;
    //building a grid of buttons
    Widget grid = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Field(0, 0),
            Field(0, 1),
            Field(0, 2),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Field(1, 0),
            Field(1, 1),
            Field(1, 2),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Field(2, 0),
            Field(2, 1),
            Field(2, 2),
          ],
        )
      ],
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ), // remove decoration
      ),
      width: screenWidth,
      height: screenHeight * 0.70, //grid occupies most of the screen
      child: grid,
    );
  }
}

class Field extends StatefulWidget {
  int x, y;
  bool state;

  Field(int x, int y) {
    this.x = x;
    this.y = y;
    this.state = false; //not clicked
  }
  @override
  State<StatefulWidget> createState() {
    return _FieldState();
  }
}

class _FieldState extends State<Field> {
  void _handleTap() {
    //needs implementation
    if (widget.state == false) {
      widget.state = true;
      setState(() {});
    } else {
      print("vec kliknuto");
    }
  }

  void resetField() {
    widget.state = false;
    setState(() {});
  }

  Widget build(BuildContext context) {
    double screenHeight =
        MediaQuery.of(context).size.height; // get size of screen
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 5.0)),
        width: screenWidth * 0.32,
        height: screenHeight * 0.22,
        margin: EdgeInsets.all(0.0),
        child: FlatButton.icon(
          icon:
              widget.state == false ? (Icon(Icons.not_interested)) : setIcon(),
          label: Text(""),
          onPressed: _handleTap,
        ));
  }

  Widget setIcon() {
    if (turn == "o") {
      changeTurn();
      return Icon(Icons.panorama_fish_eye);
    } else {
      changeTurn();
      return Icon(Icons.add);
    }
  }
}
