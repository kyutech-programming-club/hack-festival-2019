class Area
{
  int x, y, width, height;
  Area(int x, int y, int w, int h)
  {
    this.x      = x;
    this.y      = y;
    this.width  = w;
    this.height = h;
  }
  
  boolean in_range(PVector pos)
  {
    return (this.x<=pos.x && pos.x<=this.x+this.width)&&(this.y<=pos.y && pos.y<=this.y+this.height);
  }
  
  void draw(color c)
  {
    fill(c);
    rect(this.x, this.y, this.width, this.height);
  }
};

PVector get_right_hand_pos()
{
  if (leap.hasHands())
  {
    Hand hand = leap.getHands().get(0);
    return hand.getPosition();
  }
  return new PVector(0, 0);
}

//String get_answer_with_hand()
//{
//  PVector right_hand_pos = get_right_hand_pos();
//  if (fukuoka_area.in_range(right_hand_pos))
//  {
//    return fukuoka_gesture;
//  }
//  else if (other_area.in_range(right_hand_pos))
//  {
//    return other_gesture;
//  }
//  else
//  {
//    return "";
//  }
//}
