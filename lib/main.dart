import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "settings.dart";

//zadatak 2 AI

var playWithComp = true;
var globalDifficulty = 0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      theme: ThemeData.dark(),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class WinnerLine extends CustomPainter {
  Offset start;
  Offset end;

  WinnerLine(double s1, s2, e1, e2)
      : start = new Offset(s1, s2),
        end = new Offset(e1, e2);

  @override
  void paint(Canvas canvas, Size size) {
    //create a paint - set it's properties
    Paint paint = new Paint()
      //..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 40.0
      ..color = Colors.red;
    canvas.drawLine(this.start, this.end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _HomePageState extends State<homePage> {
  List<List> _matrix;

  _HomePageState() {
    _initMatrix();
  }

  _initMatrix() {
    _matrix = List<List>(3);
    for (var i = 0; i < _matrix.length; i++) {
      _matrix[i] = List(3);
      for (var j = 0; j < _matrix.length; j++) {
        _matrix[i][j] = ' ';
      }
    }
  }

//on help button pressed call this to open settings
  Widget get _openSettings {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameSettings()),
    );
  }

  void _handleTapDown(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject();
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
      //_tapPosition = details.globalPosition;
      /*print("local:" +
          referenceBox.globalToLocal(details.globalPosition).toString() +
          "global:" +
          details.globalPosition.toString());*/
    });
  }

  nextTurn() => _turn == "o" ? _next = "x" : _next = "o";

  String _turn = "o";
  String _next = "x";
  int _scoreX = 0;
  int _scoreO = 0;
  List<double> _coords = new List.filled(4, -20.0);
  Offset _tapPosition;

  _resetLineCoords() {
    _coords[0] = -20;
    _coords[1] = -20;
    _coords[2] = -20;
    _coords[3] = -20;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TicTacToe"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                _openSettings;
              },
            )
          ],
        ),
        body: Column(children: [
          CustomPaint(
              painter:
                  //koordinate x,y pocetka i kraja crte
                  WinnerLine(_coords[0], _coords[1], _coords[2], _coords[3])),
          Container(
            height: 70.0,
            child: Text(
              " $_scoreX : $_scoreO ",
              style: TextStyle(fontSize: 50.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildElement(0, 0),
                    _buildElement(0, 1),
                    _buildElement(0, 2),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildElement(1, 0),
                    _buildElement(1, 1),
                    _buildElement(1, 2)
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildElement(2, 0),
                    _buildElement(2, 1),
                    _buildElement(2, 2)
                  ],
                )
              ],
            ),
          ),
          Container(
              height: 90.0,
              alignment: Alignment(0.0, 1.0),
              child: GestureDetector(
                onLongPress: () {
                  setState(() {
                    _scoreO = 0;
                    _scoreX = 0;
                    _resetLineCoords();
                    _initMatrix();
                    Fluttertoast.showToast(
                        msg: "Game reset",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity
                            .CENTER, // also possible "TOP" and "CENTER"
                        backgroundColor: Colors.black38,
                        textColor: Colors.white);
                  });
                },
                child: Text("Turn: $_next", style: TextStyle(fontSize: 50.0)),
              )),
        ]));
  }

  _buildElement(int x, int y) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTap: () {
        _changeMatrixField(x, y);
        if (_gameWon(x, y) != 0) {
          _showDialog(true);
          //_drawWin(result);
        } else if (_gameDraw()) {
          _showDialog(false);
        }
      },
      child: Container(
          width: 130,
          height: 160,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.white)),
          child: Padding(
            padding: EdgeInsets.only(bottom: 1.0),
            child: Center(
              child: Text(_matrix[x][y],
                  style: TextStyle(fontSize: 150.0),
                  textAlign: TextAlign.center),
            ),
          )),
    );
  }

  _changeMatrixField(int x, int y) {
    setState(() {
      if (_matrix[x][y] == ' ') {
        if (_turn == 'o')
          _turn = 'x';
        else
          _turn = 'o';

        _matrix[x][y] = _turn;
      }
      nextTurn();
    });
  }

  _gameWon(int x, int y) {
    var col = 0, row = 0, diagonal = 0, rdiagonal = 0;
    var n = _matrix.length - 1;
    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == _turn) col++;
      if (_matrix[i][y] == _turn) row++;
      if (_matrix[i][i] == _turn) diagonal++;
      if (_matrix[i][n - i] == _turn) rdiagonal++;
    }

    _calculatePossitionY() {
      if (_tapPosition.dy < 385)
        return 210.0;
      else if (_tapPosition.dy > 285 && _tapPosition.dy < 430)
        return 365.0;
      else
        return 535.0;
    }

    _calculatePossitionX() {
      print(_tapPosition.dx);
      if (_tapPosition.dx > 13 && _tapPosition.dx < 140)
        return -125.0;
      else if (_tapPosition.dx > 140 && _tapPosition.dx < 270)
        return 0.0;
      else
        return 130.0;
    }
  // fixed coordinates for now
    if (col == n + 1) {
      var y = _calculatePossitionY();
      _coords[0] = -170;
      _coords[1] = y;
      //_coords[1] = _tapPosition.dy.abs() - 80;
      _coords[2] = 170; // gornja live kutije
      //_coords[3] = _tapPosition.dy.abs() - 80;
      _coords[3] = y;
    } else if (row == n + 1) {
      var x = _calculatePossitionX();
      _coords[0] = x;
      //_coords[0] = _tapPosition.dx.abs() - 200;
      _coords[1] = 150;
      //_coords[2] = _tapPosition.dx.abs() - 200;
      _coords[2] = x;
      _coords[3] = 560;
    } else if (diagonal == n + 1) {
      _coords[0] = -170;
      _coords[1] = 150;
      _coords[2] = 170;
      _coords[3] = 570;
    } else if (rdiagonal == n + 1) {
      _coords[0] = 170;
      _coords[1] = 150;
      _coords[2] = -170;
      _coords[3] = 570;
    } else {
      return 0;
    }
  }

  _gameDraw() {
    var draw = true;
    _matrix.forEach((i) {
      i.forEach((j) {
        if (j == ' ') draw = false;
        return draw;
      });
    });
    return draw;
  }

  _showDialog(bool winner) {
    String dialogText;
    if (winner == false)
      dialogText = "Draw";
    else {
      dialogText = "$_turn won the game";
      if (_turn == "x")
        _scoreX++;
      else
        _scoreO++;
    }
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: Text("Game over"),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                child: Text("Next round"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _initMatrix();
                    _resetLineCoords();
                  });
                },
              )
            ],
          );
        });
  }
}
