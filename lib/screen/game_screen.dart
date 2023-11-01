import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';


class GameScreen extends StatefulWidget {
  String player1;
  String player2;
  GameScreen({required this.player1,required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;
  
  
  @override

  void initState(){
    super.initState();
    _board = List.generate(3, (index) => List.generate(3, (index) => ""));
    _currentPlayer = "X";
    _winner="";
    _gameOver = false;
  }

  void _resetGame(){
    setState(() {
      _board = List.generate(3,(index) => List.generate(3, (index) => ""));
    _currentPlayer = "X";
    _winner="";
    _gameOver = false; 
    });
  }
  void _makeMove(int row,int col){
    if(_board[row][col] !="" || _gameOver){
      return;
    }
    setState(() {
      _board[row][col] = _currentPlayer;

      //checking for a winner
      // for all rows
      if(_board[row][0] == _currentPlayer && _board[row][1] == _currentPlayer && _board[row][2] == _currentPlayer){
        _winner = _currentPlayer;
        _gameOver = true;
      }
      // for all columns
      else if(_board[0][col] == _currentPlayer && _board[1][col] == _currentPlayer && _board[2][col] == _currentPlayer){
        _winner = _currentPlayer;
        _gameOver = true;
      }
      // for diagonal of top left to bottom right
      else if(_board[0][0] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][2] == _currentPlayer){
        _winner = _currentPlayer;
        _gameOver = true;
      }
      //for diagonal of top right to bottom left
      else if(_board[0][2] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][0] == _currentPlayer){
        _winner = _currentPlayer;
        _gameOver = true;
      }

      // switch player
      _currentPlayer = _currentPlayer == "X" ? "O" : "X";
      if(!_board.any((row) => row.any((cell)=> cell == ""))){
        _gameOver = true;
        _winner = "It's a Tie";

      }

    if(_winner !=""){
      AwesomeDialog(context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      btnOkText: "Play Again",
      title: _winner == "X"? widget.player1+ ' Won!!': _winner == "O" ? widget.player2+" Won!!" : "It's a Tie",
      btnOkOnPress: (){
        _resetGame();
      },
      ).show();
    }

      
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D58),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70,),
            SizedBox(height:120,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget> [
                    const Text("Turn:",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      ),
                    ),
                    Text(_currentPlayer == "X" ? widget.player1 + '($_currentPlayer)' : widget.player2 + '($_currentPlayer)' ,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _currentPlayer == 'X' ? Colors.redAccent : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),

              ],
            ),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF5F6B84),
                borderRadius: BorderRadius.circular(10)
              ),
              margin: const EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: ((context, index) {
                  int row = index~/3;
                  int col =index%3;
                  return GestureDetector(
                    onTap: () {
                      _makeMove(row, col);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(123, 51, 50, 50),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: 
                      Text(_board[row][col],
                      style: TextStyle(
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                        color: _board[row][col] =='X' ? Colors.redAccent : Colors.green,
                      ),),),
                    ) ,
                  );
                } )),

            ),
            const SizedBox(height: 20.0,),
            InkWell(
              onTap: (){
                _resetGame();

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 20),
              child: const Text("Reset Game",
              style: TextStyle(
                fontSize: 24 ,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),),
              ),
            )

          ],
        ),
      ),
    );
  }
}