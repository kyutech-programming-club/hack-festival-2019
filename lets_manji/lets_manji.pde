import de.voidplus.leapmotion.*;
import java.util.Collections;
import java.util.Map;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Arrays;
import processing.opengl.*;

LeapMotion leap;

Timer game_timer;
Timer unit_timer;

GestureSocket gesture_socket;

HashMap<String, Boolean> image_judge_table;
List<String> image_names;

HashMap<String, ImageInfo> image_info_table;

String current_image_name;
String prev_image_name;
PImage current_image;
int image_x, image_y;

String correct_gesture;

final String fukuoka_gesture = "swipe";
final String other_gesture   = "screen_tap";

ResultDisplay result_display;
//Area fukuoka_area, other_area;
ImageTransformer appear_image_tf;
//ImageTransformer swipe_image_tf;

ScoreBoard score_board;

final int intro  = 0;
final int main   = 1;
final int end    = 2;
final int result = 3;

int mode;

void setup()
{
  size(1600, 1000);
  draw_background();

  leap = new LeapMotion(this).allowGestures(fukuoka_gesture + ", " + other_gesture);

  gesture_socket = new GestureSocket();

  // Load image-names and judges
  image_judge_table = new HashMap<String, Boolean>();

  String data_dirname = "/home/wata/works/my_works/kyutech_programming_club/hack-festival-2018/lets_manji/data/";
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
  image_info_table.put(other_dir+"/kaparu.jpg", new ImageInfo("カパル（志木市のゆるキャラ）", "埼玉"));
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


  image_info_table.put(fukuoka_dir+"/akarenga-bunkaten.jpg", new ImageInfo("赤煉瓦文化館", "福岡"));
  image_info_table.put(fukuoka_dir+"/dazaihu.jpg", new ImageInfo("太宰府天満宮", "福岡"));
  image_info_table.put(fukuoka_dir+"/dazaihu-sutaba-nonfree.jpg", new ImageInfo("太宰府のスタバ", "福岡"));
  image_info_table.put(fukuoka_dir+"/fukuoka.png", new ImageInfo("福岡の図", "福岡"));
  image_info_table.put(fukuoka_dir+"/fukuoka-mark.png", new ImageInfo("福岡県章", "福岡"));
  image_info_table.put(fukuoka_dir+"/hakataniwaka_omen.png", new ImageInfo("博多にわか", "福岡"));
  image_info_table.put(fukuoka_dir+"/hakata-port-tower.jpg", new ImageInfo("博多ポートタワー", "福岡"));
  image_info_table.put(fukuoka_dir+"/hakata-station.jpg", new ImageInfo("博多駅", "福岡"));
  image_info_table.put(fukuoka_dir+"/hiraodai.jpg", new ImageInfo("平尾台", "福岡"));
  image_info_table.put(fukuoka_dir+"/hukuoka-airport.jpg", new ImageInfo("福岡空港", "福岡"));
  image_info_table.put(fukuoka_dir+"/irukaya.jpg", new ImageInfo("海豚や", "福岡"));
  image_info_table.put(fukuoka_dir+"/itoshima.jpg", new ImageInfo("糸島", "福岡"));
  image_info_table.put(fukuoka_dir+"/kokurakeibazyou.jpg", new ImageInfo("小倉競馬場", "福岡"));
  image_info_table.put(fukuoka_dir+"/kokurazyou.jpg", new ImageInfo("小倉城", "福岡"));
  image_info_table.put(fukuoka_dir+"/kushinada-zinzya-setubun.jpg", new ImageInfo("櫛田神社", "福岡"));
  image_info_table.put(fukuoka_dir+"/kyu-koukaidou-kihinkan.jpg", new ImageInfo("旧福岡県公開堂貴賓館", "福岡"));
  image_info_table.put(fukuoka_dir+"/kyumozizeikan.jpg", new ImageInfo("旧門司税関", "福岡"));
  image_info_table.put(fukuoka_dir+"/maizurukouen-sakura.jpg", new ImageInfo("舞鶴公園", "福岡"));
  image_info_table.put(fukuoka_dir+"/mentaiko.png", new ImageInfo("明太子", "福岡"));
  image_info_table.put(fukuoka_dir+"/meoto.jpg", new ImageInfo("夫婦岩", "福岡"));
  image_info_table.put(fukuoka_dir+"/motunabe.jpg", new ImageInfo("もつ鍋", "福岡"));
  image_info_table.put(fukuoka_dir+"/nehanzou.jpg", new ImageInfo("南蔵院", "福岡"));
  image_info_table.put(fukuoka_dir+"/nishikouen-kouunzinzya.jpg", new ImageInfo("光雲神社", "福岡"));
  image_info_table.put(fukuoka_dir+"/omikoshi_hakata_gion_yanakasa.png", new ImageInfo("博多祇園山笠", "福岡"));
  image_info_table.put(fukuoka_dir+"/rakusuien.jpg", new ImageInfo("楽水園", "福岡"));
  image_info_table.put(fukuoka_dir+"/sasaguri-kyudainomori.jpg", new ImageInfo("笹栗九大の森", "福岡"));
  image_info_table.put(fukuoka_dir+"/shinshin.jpg", new ImageInfo("博多ラーメンshinshin", "福岡"));
  image_info_table.put(fukuoka_dir+"/taihouramen.jpg", new ImageInfo("久留米大砲ラーメン", "福岡"));
  image_info_table.put(fukuoka_dir+"/tetunabe.jpg", new ImageInfo("鉄なべ", "福岡"));
  image_info_table.put(fukuoka_dir+"/tikugogawa-syokaikyo.jpg", new ImageInfo("筑後川昇開橋", "福岡"));
  image_info_table.put(fukuoka_dir+"/tutuji.jpg", new ImageInfo("つつじ（県の木）", "福岡"));
  image_info_table.put(fukuoka_dir+"/uguisu.jpg", new ImageInfo("ウグイス（県の鳥）", "福岡"));
  image_info_table.put(fukuoka_dir+"/ume.jpg", new ImageInfo("梅（県の花）", "福岡"));
  image_info_table.put(fukuoka_dir+"/uminonakamichi.jpg", new ImageInfo("海の中道", "福岡"));
  image_info_table.put(fukuoka_dir+"/yahuokudo-mu.jpg", new ImageInfo("ヤフオクドーム", "福岡"));
  image_info_table.put(fukuoka_dir+"/yakei.jpg", new ImageInfo("福岡市の夜景", "福岡"));
  image_info_table.put(fukuoka_dir+"/yusentei.jpg", new ImageInfo("友泉亭公園", "福岡"));
  image_info_table.put(fukuoka_dir+"/kuruppa.jpg", new ImageInfo("くるっぱ（久留米市のゆるキャラ）", "福岡"));  

  appear_image_tf  =  new ImageTransformer(new PVector(width/2 , height + current_image.height/2),
                                           new PVector(current_image.width, current_image.height),
                                           new PVector(width/2, height*3/5),
                                           new PVector(current_image.width, current_image.height),
                                           3000);
                                           
  //swipe_image_tf   =  new ImageTransformer(new PVector(width/2, height*3/5),
  //                                         new PVector(current_image.width, current_image.height),
  //                                         new PVector(-current_image.width/2, height*3/5),
  //                                         new PVector(current_image.width, current_image.height),
  //                                         500);
                                    

  unit_timer = new Timer(5*1000);
  //game_timer = new Timer(5*1000*image_names.size());
  game_timer = new Timer(60*1000);

  result_display = new ResultDisplay(3*1000);

  //fukuoka_area = new Area(width/4, height/4, 100, 100);
  //other_area   = new Area(width*3/4, height/4, 100, 100);
  
  score_board = new ScoreBoard();
  
  mode = intro;
}

void draw()
{
  switch (mode)
  {
    case intro:
      draw_background();
      game_timer.reset();
      unit_timer.reset();

      appear_image_tf.timer.reset();
      //draw_hand();
      break;
    case main:
      draw_background();
      //draw_max_canvas();
    
      if (result_display.is_active())
      {
        result_display.display();
        return;
      }
      
      appear_image();

      //appear_image_tf.transform();
    
      unit_timer.start();
    
      game_timer.update();
      unit_timer.update();
    
      draw_time_gage();
      draw_game_time();
      // fukuoka_area.draw(color(255, 0, 0));
      // other_area.draw(color(0, 0, 255));
      score_board.draw();
      draw_hand();
    
      if (unit_timer.should_reset())  // Unit is timed-up
      {
        score_board.toggle(ScoreBoard.reduce);
        result_display.activate(result_display.timeup);
        //appear_image_tf.reset();
        if (image_names.size() > 0 ) 
        {
          update_image();
        }
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
          score_board.toggle(ScoreBoard.add);
        } else
        {
          println("あひーーーー");
          background(0, 0, 0, 200);
          text("あひ！！", width/2, height/2);
          result_display.activate(result_display.incorrect);
          score_board.toggle(ScoreBoard.reduce);
        }
        if (image_names.size() > 0) 
        {        
          //appear_image_tf.reset();
          update_image();
        }
      }
      if (image_names.size() == 0 || game_timer.should_reset()) 
      {
          mode = end;
          return;
      }
    
      break;
    case end:
      result_display.activate(result_display.finish);
      break;
    case result:
      result_display.activate(score_board.get() > 150 ? result_display.good_finish : result_display.bad_finish);    
      break;
  }
  if (result_display.is_active())
  {
    result_display.display();
  }
}

void keyReleased()
{
  if (mode == intro)
  {
    mode = main;
    delay(1000);
  }
  else if (mode == end)
  {
    mode = result;
  }
  else if (mode == result)
  {
    mode = intro;
  }
}
