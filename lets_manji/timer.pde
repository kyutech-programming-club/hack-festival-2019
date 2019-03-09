class Timer
{
  int start, now;
  int time_limit;
  
  Timer(int limit)
  {
    start = now = 0;
    time_limit = limit;
  }
  
  void start()
  {
    if (should_reset())
    {
      println("RESET!!!");
      start = millis();
    }
  }
  
  void update()
  {
    now = millis();
  }
  
  int duration()
  {
    return now - start;
  }
  
  boolean should_reset()
  {
    return duration() > time_limit;
  }
}
