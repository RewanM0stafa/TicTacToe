import 'dart:io';

import 'move.dart';

class Board {
  List<List<String>> board;

  //built the board
  Board() : board = List.generate(
    3,
        (_) => List.filled(3, '', growable: false),
  );


  //check isFull
  bool isFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell == '')
          return false;
      }
    }
    return true;
  }

  //isCellAvailable
  bool isCellAvailable(int row, int col) => (board[row][col] == '');


  //checkWin
  bool checkWin(String move) {
    for (int idx = 0; idx < 3; idx++) {
      if (board[idx].every((cell) => cell == move)) return true;
      if (board[0][idx] == move &&
          board[1][idx] == move &&
          board[2][idx] == move)
        return true;
    }
      if (board[0][0] == move && board[1][1] == move && board[2][2] == move)
        return true;
      if (board[0][2] == move && board[1][1] == move && board[2][0] == move)
        return true;
      return false;
    }



  //print board
  void printBoard() {
    for (var row in board) {
      for (var cell in row) {
        stdout.write(cell.isEmpty ? '   |' : ' $cell |');
      }
      print('\n-----------'); // سطر يفصل بين الصفوف
    }
  }
  //بيستقبل قيم المتغيرات اللي حفظها كلاس الmove ويعملها assign ع البورد
  //make move
  bool makeMove(Move move){
   if(isCellAvailable(move.row, move.col)){
     board[move.row][move.col] = move.player;
     return true;
   }
   return false;

  }
//undo move
void undoMove(Move move){
    board[move.row][move.col] ='';
}
}
