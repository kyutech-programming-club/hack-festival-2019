final int image_canvas_scale = 600;

void fit_image(){
  float ratio;
  int image_width = 0, image_height = 0;
  if(current_image.width >= current_image.height){
   ratio = image_canvas_scale / current_image.width;
   image_width = image_canvas_scale;
   image_height = int(current_image.height * ratio);
  }
  else if(current_image.width < current_image.height){
   ratio = image_canvas_scale / current_image.height;
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
  String next_image_name = pop_next_image_name();
  current_image = loadImage(next_image_name);
  fit_image();
  boolean is_fukuoka = image_judge_table.get(next_image_name);
  correct_gesture = is_fukuoka ? fukuoka_gesture : other_gesture;
}
