final int image_canvas_scale = 600;

void fit_image() {
  float ratio;
  int image_width = 0, image_height = 0;
  if (current_image.width >= current_image.height)
  {
    ratio = (float)image_canvas_scale / (float)current_image.width;
    image_width = image_canvas_scale;
    image_height = int(current_image.height * ratio);
  } else if (current_image.width < current_image.height)
  {
    ratio = (float)image_canvas_scale / (float)current_image.height;
    image_height = image_canvas_scale;
    image_width = int(current_image.width * ratio);
  }
  current_image.resize(image_width, image_height);
}

String pop_next_image_name()
{
  int selected_index = (int)random(image_names.size());
  String next_name = image_names.get(selected_index);
  image_names.remove(selected_index);
  return next_name;
}



void update_image()
{
  prev_image_name = current_image_name;
  current_image_name = pop_next_image_name();
  current_image = loadImage(current_image_name);
  fit_image();
  PVector image_pos = gen_default_image_pos();
  image_x = (int)image_pos.x;
  image_y = (int)image_pos.y;
  boolean is_fukuoka = image_judge_table.get(current_image_name);
  correct_gesture = is_fukuoka ? fukuoka_gesture : other_gesture;
}

PVector gen_default_image_pos()
{
  PVector result = new PVector(width/2, height*3/5);
  return result;
}

void appear_image(){
   //appear_image_tf.transform();
   imageMode(CENTER);
   image(current_image, image_x, image_y);
   imageMode(CORNER);
}

void show_answer()
{
  PImage prev_image = loadImage(prev_image_name);
  float ratio;
  int image_width = 0, image_height = 0;
  if (prev_image.width >= prev_image.height)
  {
    ratio = (float)image_canvas_scale / (float)prev_image.width;
    image_width = image_canvas_scale;
    image_height = int(prev_image.height * ratio);
  } else if (prev_image.width < prev_image.height)
  {
    ratio = (float)image_canvas_scale / (float)prev_image.height;
    image_height = image_canvas_scale;
    image_width = int(prev_image.width * ratio);
  }
  prev_image.resize(image_width, image_height);
  image(prev_image, image_x, image_y);

  if (image_info_table.containsKey(prev_image_name))
  {
    ImageInfo image_info = image_info_table.get(prev_image_name);
    
    fill(255);
    text(image_info.name + "(" + image_info.location + ")", width/2-prev_image.width/2, height/2-prev_image.height/2);
  }
}

void swipe_image(){
   //swipe_image_tf.transform();
   imageMode(CENTER);
   image(current_image, image_x, image_y);
   imageMode(CORNER);
}
