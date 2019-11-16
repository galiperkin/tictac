import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO: Link up images

  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage edit = AssetImage("images/edit.png");

  bool isCross = true;
  bool isEnd = false;
  String message;

  List<String> gameState;

  //TODO: Initialize the state of box with empty
  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }
  //TODO: playGame method

  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = "cross";
        } else {
          this.gameState[index] = "circle";
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
    if (this.isEnd == true) {
      this.checkEnd();
    }
  }

  checkEnd() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      this.resetGame();
      this.isEnd = false;
    });
  }

  //TODO: Reset game method
  resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  //TODO:get image method
  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;
      case ('cross'):
        return cross;
        break;
      case ('circle'):
        return circle;
        break;
    }
  }

  //TODO: check for win logic
  checkWin() {
    //check 1. row
    if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[1]) &&
        (gameState[1] == gameState[2]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
        this.isEnd = true;
      });
    }
    //check 2. row
    else if ((gameState[3] != 'empty') &&
        (gameState[3] == gameState[4]) &&
        (gameState[4] == gameState[5]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[3]} Wins';
        this.isEnd = true;
      });
    }
    //check 3. row
    else if ((gameState[6] != 'empty') &&
        (gameState[6] == gameState[7]) &&
        (gameState[7] == gameState[8]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[6]} Wins';
        this.isEnd = true;
      });
    }
    //check 1. column
    else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[3]) &&
        (gameState[3] == gameState[6]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
        this.isEnd = true;
      });
    }
    //check 2. column
    else if ((gameState[1] != 'empty') &&
        (gameState[1] == gameState[4]) &&
        (gameState[4] == gameState[7]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[1]} Wins';
        this.isEnd = true;
      });
    }
    //check 3. column
    else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[5]) &&
        (gameState[5] == gameState[8]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[2]} Wins';
        this.isEnd = true;
      });
    }
    //check TL to BR
    else if ((gameState[0] != 'empty') &&
        (gameState[0] == gameState[4]) &&
        (gameState[4] == gameState[8]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[0]} Wins';
        this.isEnd = true;
      });
    }
    //check TR to BL
    else if ((gameState[2] != 'empty') &&
        (gameState[2] == gameState[4]) &&
        (gameState[4] == gameState[6]) &&
        (isEnd == false)) {
      setState(() {
        this.message = '${this.gameState[2]} Wins';
        this.isEnd = true;
      });
    }
    //check draw
    else if (!gameState.contains('empty')) {
      setState(() {
        this.message = "Game Draw";
        this.isEnd = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TicTacToe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //if you want to use grid view, you need "Expanded"
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(1.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.red,
            minWidth: 300.0,
            height: 50.0,
            child: Text(
              "Reset Game",
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            onPressed: () {
              this.resetGame();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "First Tic Tac Toe in Flutter",
              style: TextStyle(fontSize: 18.0),
            ),
          )
        ],
      ),
    );
  }
}
