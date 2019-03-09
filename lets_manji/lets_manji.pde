import de.voidplus.leapmotion.*;
import java.util.Collections;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Arrays;

LeapMotion leap;

Timer game_timer;
Timer unit_timer;

GestureSocket gesture_socket;

HashMap<String, Boolean> image_judge_table;
List<String> image_names;

PImage current_image;
String correct_gesture;

final String fukuoka_gesture = "swipe";
final String other_gesture   = "screen_tap";

void setup()
{
  size(800, 800);
  background(255);

  leap = new LeapMotion(this).allowGestures(fukuoka_gesture + ", " + other_gesture);

  gesture_socket = new GestureSocket();

  // Load image-names and judges
  image_judge_table = new HashMap<String, Boolean>();

  String data_dirname = "/home/tanacchi/works/hack-festival-2018/lets_manji/data/";
  File fukuoka_dir = new File(data_dirname + "fukuoka_images");
  for (File fukuoka_image : fukuoka_dir.listFiles())
  {
    image_judge_table.put(fukuoka_image.toString(), true);
  }
  File other_dir = new File(data_dirname + "other_images");
  for (File other_image : other_dir.listFiles())
  {
    image_judge_table.put(other_image.toString(), false);
  }

  String[] string_list_raw = image_judge_table.keySet().toArray(new String[image_judge_table.size()]);
  image_names = new ArrayList<String>(Arrays.asList(string_list_raw));
  update_image();
  
  unit_timer = new Timer(5*1000);
  game_timer = new Timer(5*1000*image_names.size());
}

void draw()
{
  background(255);
  image(current_image,  width/2 - current_image.width/2, height/2);

  game_timer.start();
  unit_timer.start();

  game_timer.update();
  unit_timer.update();

  draw_time_gage();

  if (image_names.size() == 0 || game_timer.should_reset())
  {
    exit_game();
  }
  if (unit_timer.should_reset())
  {
    update_image();
  }
  if (gesture_socket.can_accessed())
  {
    String detected_gesture = gesture_socket.getGesture();
    if (correct_gesture == detected_gesture)
    {
      println("Result: Good !!!!!!!");
    }
    else
    {
      println("Result: Bad !!!!!!!");    
    }
  }
}

void exit_game()
{
  background(0);
  fill(0);
  println("Finish..");
  text("Thank you for playing !", width/2, height/2);
  delay(3000);
  exit();
}
