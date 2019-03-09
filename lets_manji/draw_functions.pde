void draw_time_gage()
{
  fill(200);
  rect(100, 100, 600, 20);
  fill(255, 0, 0);
  float rate = (float)unit_timer.duration() / (float)unit_timer.time_limit;
  rect(100, 100, 600*(1 - rate), 20);
}
