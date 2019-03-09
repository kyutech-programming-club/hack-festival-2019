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
int image_x, image_y;

String correct_gesture;

final String fukuoka_gesture = "swipe";
final String other_gesture   = "screen_tap";

ResultDisplay result_display;
Area fukuoka_area, other_area;

void setup()
{
  size(1600, 1000);
  draw_background();

  leap = new LeapMotion(this).allowGestures(fukuoka_gesture + ", " + other_gesture);

  gesture_socket = new GestureSocket();

  // Load image-names and judges
  image_judge_table = new HashMap<String, Boolean>();

  String data_dirname = "/home/ryuto/hack-festival-2018/lets_manji/data/";
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
  
  result_display = new ResultDisplay(3000);
  
  fukuoka_area = new Area(width/4,   height/4, 100, 100);
  other_area   = new Area(width*3/4, height/4, 100, 100);
}

void draw()
{

  draw_background();
  //draw_max_canvas();

  if (result_display.is_active())
  {
    result_display.display();
    return;
  }

  image(current_image, image_x, image_y);
  ImageTransformer image_tf  =  new ImageTransformer(new PVector(image_x, image_y), 
                                                     new PVector(current_image.width, current_image.height),
                                                     new PVector(0, 0),
                                                     new PVector(current_image.width, current_image.height),
                                                     3000);
  image_tf.transform();

  game_timer.start();
  unit_timer.start();

  game_timer.update();
  unit_timer.update();

  draw_time_gage();
  //fukuoka_area.draw(color(255, 0, 0));
  //other_area.draw(color(0, 0, 255));
  
  for (Hand hand : leap.getHands())
  {
    hand.draw();
  }
  
  PVector right_hand_pos = get_right_hand_pos();
  fill(0, 200, 0);
  ellipse(right_hand_pos.x, right_hand_pos.y, 25, 25);
  
  if (image_names.size() == 0 || game_timer.should_reset()) 
  {
    exit_game();
  }
  if (unit_timer.should_reset())  // Unit is timed-up
  {
    result_display.activate(result_display.timeup);
    update_image();
  }
  if (gesture_socket.can_accessed())
  {
    String gesture = gesture_socket.getGesture();
    println(gesture + " detected.");
    if (gesture == correct_gesture)
    {
      println("正解！！");
      background(0, 0, 0, 200);
      text("正解！！", width/2, height/2);
      result_display.activate(result_display.correct);
    }
    else
    {
      println("あひーーーー");
      background(0, 0, 0, 200);
      text("あひ！！", width/2, height/2);
      result_display.activate(result_display.incorrect);
    }
    update_image();
  }
  
  if (result_display.is_active())
  {
    result_display.display();
  }
}

void exit_game()
{
  background(0);
  fill(0);
  println("Finish..");
  text("Thank you for playing !", width/2, height/2);
  delay(10000);
  exit();
}
