class ScoreBoard
{
  static final int add    = 100;
  static final int reduce = -50;
  
  int score;
  ScoreBoard()
  {
    score = 0;
  }
  
  void toggle(final int num)
  {
    score += num;
  }
  
  void draw()
  {
    text("得点：" + score, 100, 100);
  }
  
  int get()
  {
    return score;
  }
};
