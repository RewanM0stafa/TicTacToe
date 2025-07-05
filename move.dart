// وظيفته بشكل عام بيستقبل الداتا أو الحركات اللي اللاعبين عملوها ويخزنها ف المتغيرات اللي متعرفة هنا
class Move {
final int row,col; //مكان الحركة
final String player;

//الكونستركتور العادي اللي هستدعيه جوا الfactory
Move({required this.row, required this.col, required this.player});

  int get position =>(row*3) + col;


// Factory constructor: يبني Move من position
  //بيرجع كائن مختلف
factory Move.fromPosition(int position, String symbolPlayed) {
  int row = position ~/ 3;
  int col = position % 3;
  return Move(row: row, col: col, player: symbolPlayed);
}

}
