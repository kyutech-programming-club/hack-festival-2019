void draw_time_gage()
{
  fill(200);
  rect(100, 100, 600, 20);
  fill(255, 0, 0);
  float rate = (float)unit_timer.duration() / (float)unit_timer.time_limit;
  rect(100, 100, 600*(1 - rate), 20);
}

class ResultDisplay
{
  final int correct   = 0;
  final int incorrect = 1;
  final int timeup    = 2;
  
  int mode;
  Timer timer;
  boolean is_active;
  
  ResultDisplay(int limit)
  {
    timer = new Timer(limit);
    is_active = false;
  }
  
  void activate(int m)
  {
    mode = m;
    timer.start();
    is_active = true;
  }
  
  void display()
  {
    timer.update();
    switch (mode)
    {
      case correct:
        display_correct();
        break;
      case incorrect:
        display_incorrect();
        break;
      case timeup:
        display_timeup();
        break;
    }
    if (timer.should_reset())
    {
      is_active = false;
    }
  }
 
  void display_correct()
  {
    background(0 , 0, 0, 250);
    text("正解！！", width/2, height/2);
  }

  void display_incorrect()
  {
    background(0, 0, 0, 200);
    text("あひーー", width/2, height/2);
  }
  
  void display_timeup()
  {
    background(0, 0, 0, 200);
    text("時間切れ", width/2, height/2);
  }

  boolean is_active()
  {
    return is_active;
  }
}
