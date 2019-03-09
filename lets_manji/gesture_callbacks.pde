//void leapOnSwipeGesture(SwipeGesture gesture, int state)
//{
//  if (state == 3)
//  {
//    gesture_socket.setGesture(fukuoka_gesture);
//  }
//}

//void leapOnScreenTapGesture(ScreenTapGesture gesture)
//{
//  gesture_socket.setGesture(other_gesture);
//}

class GestureSocket
{
  boolean can_accessed;
  String  gesture_name;
  
  GestureSocket()
  {
    gesture_name = "";
    can_accessed = false;
  }
  
  void setGesture(String name)
  {
    gesture_name = name;
    can_accessed = true;
  }
  
   String getGesture()
   {
     if (can_accessed)
     {
       can_accessed = false;
       return gesture_name;
     }
     else
     {
       return "";
     }
   }
   
   boolean can_accessed()
   {
     return can_accessed;
   }
}
