import de.voidplus.leapmotion.*;

LeapMotion leap;

Timer game_timer;
Timer unit_timer;

GestureSocket gesture_socket;

void setup()
{
  size(800, 800);
  background(0);
  
  leap = new LeapMotion(this).allowGestures("swipe, key_tap");
  
  game_timer = new Timer(30*1000);
  unit_timer = new Timer( 5*1000);
  
  gesture_socket = new GestureSocket();
}

void draw()
{
  background(0);
  
  game_timer.start();
  unit_timer.start();
  
  game_timer.update();
  unit_timer.update();

  int duration = unit_timer.duration();
  text("duration : " + duration, width/2, height/2);
  if (unit_timer.should_reset())
  {
    println("reset !");
  }
  
  
  if (gesture_socket.can_accessed())
  {
    String gesture_name = gesture_socket.getGesture();
    println(gesture_name + " detected.");
  }
}
