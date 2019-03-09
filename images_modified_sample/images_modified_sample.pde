PImage img;

int canvas_scale = 600;
int image_width;
int image_height;

void settings() {
  img = loadImage("fukuoka_images/nishikouen-kouunzinzya.jpg"); 
  size(800, 800);
}

void setup() {
  imageMode(CENTER);
  rectMode(CENTER);
  img.set(30, 20, color(255));
  background(0);
  goodsize();
}

void draw() {
  rect(400, 400, 600, 600);
  image(img, width/2, height/2);
    
}

void goodsize(){
  float ratio;
  if(img.width >= img.height){
   ratio = canvas_scale / img.width;
   image_width = canvas_scale;
   image_height = int(img.height * ratio);
  }
  else if(img.width < img.height){
   ratio = canvas_scale / img.height;
   image_height = canvas_scale;
   image_width = int(img.width * ratio);
  }
  img.resize(image_width, image_height);
  
}
