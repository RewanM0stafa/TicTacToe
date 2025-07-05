import 'dart:math';
import 'board.dart';
import 'move.dart';
class AIAlgo {
  final String aiSymbol;
  final String humanSymbol;


  AIAlgo({required this.aiSymbol, required this.humanSymbol});

  //                     levels,#moves     winner            ai        human
  int minimax(Board board, int depth, bool isMaximizing, int alpha, int beta) {
    if (board.checkWin(aiSymbol)) return 10 - depth; //ai win
    if (board.checkWin(humanSymbol)) return depth - 10; // human win
    if (board.isFull()) return 0; //تعادل


    if (isMaximizing) {
      int maxEval = -1000;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (board.isCellAvailable(row, col)) {
            Move move = Move(row: row, col: col, player: aiSymbol);
            board.makeMove(move);
            int eval = minimax(board, depth + 1, false, alpha, beta);
            board.undoMove(move);
            maxEval = max(maxEval, eval);
            alpha = max(alpha, eval);
            if (beta <= alpha) break;
          }
        }
      }
        return maxEval;
      }

    else {
      int minEval = 1000;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          if (board.isCellAvailable(row, col)) {
            Move move = Move(row: row, col: col, player: humanSymbol);
            board.makeMove(move);
            int eval = minimax(board, depth + 1, true, alpha, beta);
            board.undoMove(move);
            minEval = min(minEval, eval);
            beta = min(beta, eval);
            if (beta <= alpha) break;
          }
        }
      }
        return minEval;

    }
  }
}