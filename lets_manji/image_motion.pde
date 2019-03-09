final int image_canvas_scale = 600;

void fit_image() {
  float ratio;
  int image_width = 0, image_height = 0;
  if (current_image.width >= current_image.height)
  {
    ratio = image_canvas_scale / current_image.width;
    image_width = image_canvas_scale;
    image_height = int(current_image.height * ratio);
  } else if (current_image.width < current_image.height)
  {
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
  PVector image_pos = gen_default_image_pos();
  image_x = (int)image_pos.x;
  image_y = (int)image_pos.y;
  boolean is_fukuoka = image_judge_table.get(next_image_name);
  correct_gesture = is_fukuoka ? fukuoka_gesture : other_gesture;
}

PVector gen_default_image_pos()
{
  PVector result = new PVector(width/2 - current_image.width/2, height*3/5 - current_image.height/2);
  return result;
}

//void apper_image()
//{

//  imageMode(CENTER);
//  float image_center_x = width / 2;
//  float image_center_y = height / 5;
//  draw_background();
//  if (size_prm_x <= image_canvas_scale && size_prm_y <= image_canvas_scale) {
//    image(current_image, image_x, image_y);
//  }
//  if (image_y > -image_y) {
//    size_plm_x *= 1.1;
//    size_plm_y *= 1.1;
//    if (int(size_plm_x) > 0 && int(size_plm_y) > 0) {
//      img.resize(int(size_plm_x), int(size_plm_y));
//    }
//    y -= 10;
//  } else {
//    has_clicked = false;
//    y = height/2;
//    size_plm_x = width;
//    size_plm_y = height;
//    img = loadImage("hukuoka-tower.jpg");
//  }
//}
