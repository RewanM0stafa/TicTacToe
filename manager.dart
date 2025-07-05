import 'dart:io';
import 'board.dart';
import 'move.dart';
import 'ai_player.dart';

class GameManager {
  late Board board;
  late AIPlayer aiPlayer;
  late String currentPlayer;
  bool isTwoPlayer = false;

  GameManager() {
    _chooseGameMode();
    resetGame();
  }

  void _chooseGameMode() {
    stdout.write("Choose mode: [1] Human vs Human, [2] Human vs AI: ");
    String? choice = stdin.readLineSync();
    if (choice == '1') {
      isTwoPlayer = true;
    } else {
      isTwoPlayer = false;
    }
  }
// بعمل حاجتين : برجع البورد فاضية ، وأعمل set to players' symbol
  void resetGame() {
    board = Board();
    aiPlayer = AIPlayer(aiSymbol: 'O', humanSymbol: 'X');
    currentPlayer = 'X';
    print("\nGame reset. Let's start!\n");
    board.printBoard();
  }

  void startGame() {
    while (true) {
      print("Player $currentPlayer's turn");

      if (isTwoPlayer || currentPlayer == 'X') {
        // Human turn
        stdout.write("Enter your move (0-8): ");
        int? pos = int.tryParse(stdin.readLineSync()!);

        if (pos == null || pos < 0 || pos > 8) {
          print("Invalid input. Enter a number from 0 to 8.");
          continue;
        }

        Move move = Move.fromPosition(pos, currentPlayer);
        if (board.makeMove(move)) {
          board.printBoard();
          if (board.checkWin(currentPlayer)) {
            print('$currentPlayer wins!');
            break;
          }
          if (board.isFull()) {
            print("It's a draw!");
            break;
          }

          // Switch turn
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X'; //=> لاحتمالية إن الاثنين humans
        } else {
          print("Cell already taken. Try again.");
        }
      } else {
        // AI turn
        print("AI turn.");
        Move move = aiPlayer.getBestMove(board);
        board.makeMove(move);
        print("AI played at position ${move.position}");
        board.printBoard();

        if (board.checkWin(currentPlayer)) {
          print('AI ($currentPlayer) wins!');
          break;
        }
        if (board.isFull()) {
          print("It's a draw!");
          break;
        }

        currentPlayer = 'X';
      }
    }

    _restart();
  }

  void _restart() {
    stdout.write("\nDo you want to play again? (y/n): ");
    String? answer = stdin.readLineSync();
    if (answer?.toLowerCase() == 'y') {
      _chooseGameMode();
      resetGame();
      startGame();
    } else {
      print("Thanks for playing!");
    }
  }
}