void draw_time_gage()
{  
  fill(200);
  rect(width/4, height/20, width/2, height/20);
  fill(255, 0, 0);
  float rate = (float)unit_timer.duration() / (float)unit_timer.time_limit;
  rect(width/4, height/20, (width/2)*(1 - rate), height/20);
}

void draw_background(){
  fill(0, 255, 0);
  rect(0, height/5, width, height);
  fill(115, 66, 41);
  triangle(width/2, height/10, 0, height, width, height);
  fill(0, 0, 255);
  rect(0, 0, width, height/5);
}

//image_position_test
void draw_max_canvas(){
  fill(255);
  rect((width - image_canvas_scale)/2, height*3/10, image_canvas_scale, image_canvas_scale);
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
    gesture_socket.lock();
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
      unit_timer.reset();
      gesture_socket.release();
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
