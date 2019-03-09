class ImageTransformer
{
  PVector prev_pos, prev_size;
  PVector next_pos, next_size;
  Timer timer;
  
  ImageTransformer(PVector prev_pos, PVector prev_size, 
                    PVector next_pos, PVector next_size,
                    int limit)
  {
    this.prev_pos  = prev_pos;
    this.prev_size = prev_size;
    this.next_pos  = next_pos;
    this.next_size = next_size;
    timer = new Timer(limit);
  }
  
  void transform()
  {
    timer.start();
    timer.update();
    
    if (timer.should_reset()){
      return;
    }

    float rate = (float)timer.duration() / (float)timer.time_limit;
    
    PVector sub_next_pos = next_pos.copy();
    PVector sub_prev_pos = prev_pos.copy();
  
    PVector pos_diff = sub_next_pos.sub(prev_pos);
    PVector current_pos = sub_prev_pos.add(pos_diff.mult(rate));
    
    image_x = (int)current_pos.x;
    image_y = (int)current_pos.y;
   

    PVector sub_next_size = next_size.copy();
    PVector sub_prev_size = prev_size.copy();
  
    PVector size_diff = sub_next_size.sub(prev_size);
    PVector current_size = sub_prev_size.add(size_diff.mult(rate));
    
    if((int)current_size.x > 0 && (int)current_size.y > 0){
      current_image.resize((int)current_size.x, (int)current_size.y);
    }
  }
}
