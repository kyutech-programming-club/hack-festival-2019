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
