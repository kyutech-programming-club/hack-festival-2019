void leapOnSwipeGesture(SwipeGesture gesture, int state)
{
  if (state == 3)
  {
    //swipe_image_tf.timer.reset();
    //swipe_image();
    gesture_socket.setGesture(fukuoka_gesture);
  }
}

void leapOnScreenTapGesture(ScreenTapGesture gesture)
{
  gesture_socket.setGesture(other_gesture);
}

class GestureSocket
{
  boolean can_accessed;
  boolean is_locked; 
  
  String  gesture_name;
  
  GestureSocket()
  {
    gesture_name = "";
    can_accessed = false;
    is_locked    = false;
  }
  
  void setGesture(String name)
  {
    if (!is_locked)
    {
      gesture_name = name;
      can_accessed = true;
    }
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
   
   void lock()
   {
     is_locked = true;
   }
   
   void release()
   {
     is_locked = false;
   }
}
