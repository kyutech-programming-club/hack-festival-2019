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

HashMap<String, ImageInfo> image_info_table;

PImage current_image;
int image_x, image_y;

String correct_gesture;

final String fukuoka_gesture = "swipe";
final String other_gesture   = "screen_tap";

Area fukuoka_area, other_area;

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
  
  image_info_table = new HashMap<String, ImageInfo>();

  image_info_table.put(other_dir+"/aburasoba.jpg", new ImageInfo("油そば", "東京"));
　　image_info_table.put(other_dir+"/aburasoba2.jpg", new ImageInfo("油そば", "東京"));
　　image_info_table.put(other_dir+"/doutonnbori.jpg", new ImageInfo("道頓堀", "大阪"));
　　image_info_table.put(other_dir+"/fushimiinari.jpg", new ImageInfo("伏見稲荷大社", "京都"));
　　image_info_table.put(other_dir+"/green-land.jpg", new ImageInfo("三井グリーンランド", "熊本"));
　　image_info_table.put(other_dir+"/himejizyo.jpg", new ImageInfo("姫路城", "兵庫"));
　　image_info_table.put(other_dir+"/hokkaido.jpeg", new ImageInfo("北海道の図", "北海道"));
　　image_info_table.put(other_dir+"/itukushimazinzya.jpeg", new ImageInfo("厳島神社", "広島"));
　　image_info_table.put(other_dir+"/kaminarimon.jpg", new ImageInfo("浅草寺", "東京"));
　　image_info_table.put(other_dir+"/kaparu.jpg", new ImageInfo("カパル", "埼玉"));
　　image_info_table.put(other_dir+"/nagoya-station.jpg", new ImageInfo("名古屋駅", "愛知"));
　　image_info_table.put(other_dir+"/nagoyazyo.jpg", new ImageInfo("名古屋城", "愛知"));
　　image_info_table.put(other_dir+"/ropongi.jpg", new ImageInfo("六本木ヒルズ", "東京"));
　　image_info_table.put(other_dir+"/saigou-takamori.jpg", new ImageInfo("西郷隆盛", "鹿児島"));
　　image_info_table.put(other_dir+"/shimane_kensho.png", new ImageInfo("島根県章", "島根"));
　　image_info_table.put(other_dir+"/sky-tree.jpg", new ImageInfo("東京スカイツリー", "東京"));
　　image_info_table.put(other_dir+"/syurizyou.jpg", new ImageInfo("首里城", "沖縄"));
　　image_info_table.put(other_dir+"/tokeidai.jpg", new ImageInfo("時計台", "北海道"));
　　image_info_table.put(other_dir+"/tokyo-station.jpg", new ImageInfo("東京駅", "東京"));
　　image_info_table.put(other_dir+"/tokyo-tower.jpg", new ImageInfo("東京タワー", "東京"));


  unit_timer = new Timer(5*1000);
  game_timer = new Timer(5*1000*image_names.size());
  
  fukuoka_area = new Area(width/4,   height/4, 100, 100);
  other_area   = new Area(width*3/4, height/4, 100, 100);
}

void draw()
{
  background(255);
  image(current_image, image_x, image_y);

  game_timer.start();
  unit_timer.start();

  game_timer.update();
  unit_timer.update();

  draw_time_gage();
  fukuoka_area.draw(color(255, 0, 0));
  other_area.draw(color(0, 0, 255));
  
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
  if (unit_timer.should_reset())
  {
    String answer = get_answer_with_hand();
    if (answer == correct_gesture)
    {
      println("GOOD");
    }
    else
    {
      println("BAD");
    }
    update_image();
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
