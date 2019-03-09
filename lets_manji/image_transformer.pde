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
    
    float rate = timer.duration() / timer.time_limit;
    rate = rate > 1.0 ? 0 : rate;
    PVector pos_diff = next_pos.sub(prev_pos);
    PVector current_pos = prev_pos.add(pos_diff.mult(rate));
    image_x = (int)current_pos.x;
    image_y = (int)current_pos.y;
    //println(timer.duration());
    //println("x = " + image_x + ", y = " + image_y);

    PVector size_diff = next_size.sub(prev_size);
    PVector current_size = prev_size.add(size_diff.mult(rate));
    current_image.resize((int)current_size.x, (int)current_size.y);
  }
}
