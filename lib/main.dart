import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  String _turn = 'o';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: Center(
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
    );
  }

  _buildElement(int x, int y) {
    return GestureDetector(
      onTap: () {
        _changeMatrixField(x, y);
        if (_gameWon(x, y)) {
          _showDialog(true);
        } else if (_gameDraw()) {
          _showDialog(false);
        }
      },
      child: Container(
          width: 130,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.white)),
          child: Center(
            child: Text(_matrix[x][y], style: TextStyle(fontSize: 150.0)),
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
    if (col == n + 1 ||
        row == n + 1 ||
        diagonal == n + 1 ||
        rdiagonal == n + 1) {
      return true;
    }
    return false;
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
    else
      dialogText = "$_turn won the game";
    showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (context) {
          return AlertDialog(
            title: Text("Game over"),
            content: Text(dialogText),
            actions: <Widget>[
              FlatButton(
                child: Text("Restart game"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _initMatrix();
                  });
                },
              ),
            ],
          );
        });
  }
}
