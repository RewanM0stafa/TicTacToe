import 'board.dart';
import 'move.dart';
import 'ai_algo.dart';

class AIPlayer{
  final String aiSymbol,humanSymbol;
  late final AIAlgo algo;

  AIPlayer({required this.aiSymbol, required this.humanSymbol}) {
    algo = AIAlgo(aiSymbol: aiSymbol, humanSymbol: humanSymbol);
  }



  Move getBestMove(Board board){
    int bestScore = -1000;
    Move? bestMove;
    for (int pos = 0; pos < 9; pos++) {
      Move move = Move.fromPosition(pos, aiSymbol); // لما الai يلعب
      if (board.makeMove(move)) { // هيلوب جوا سيناريو علشان يختار الحركات اللي هتكسبه، وبعدها أرجع للوضع الأصلي وأبدأ ألعب
        int score = algo.minimax(board, 0, false, -1000, 1000);
        board.undoMove(move);

        if (score > bestScore) {
          bestScore = score;
          bestMove = move;
        }
      }
    }

    return bestMove! ;
  }
}