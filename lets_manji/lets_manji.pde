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

void setup()
{
  size(800, 800);
  background(0);

  leap = new LeapMotion(this).allowGestures("swipe, key_tap");

  game_timer = new Timer(30*1000);
  unit_timer = new Timer( 5*1000);

  gesture_socket = new GestureSocket();

  // Load image-names and judges
  image_judge_table = new HashMap<String, Boolean>();

  String data_dirname = "/home/tanacchi/works/hack-festival-2018/lets_manji/data/";
  File fukuoka_dir = new File(data_dirname + "fukuoka_images");
  for (File fukuoka_image : fukuoka_dir.listFiles())
  {
    image_judge_table.put(fukuoka_image.toString(), true);
    println("Fukuoka : " + fukuoka_image);
  }
  File other_dir = new File(data_dirname + "other_images");
  for (File other_image : other_dir.listFiles())
  {
    image_judge_table.put(other_image.toString(), false);
    println("Other : " + other_image);
  }

  String[] string_list_raw = image_judge_table.keySet().toArray(new String[image_judge_table.size()]);
  image_names = new ArrayList<String>(Arrays.asList(string_list_raw));
  
  for (int i = 0; i < image_names.size(); ++i)
  {
    println("Filename : " + image_names.get(i));
  }
}

String pop_next_image_name()
{
  int selected_index = 0;  // TODO: Make Random !!!!!!
  String next_name = image_names.get(selected_index);
  image_names.remove(selected_index);
  return next_name;
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
