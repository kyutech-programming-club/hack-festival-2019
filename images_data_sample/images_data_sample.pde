PImage img;

void setup(){
  img = loadImage("hukuoka-tower.jpg");
  size(728, 484);
  println(img.height);
  println(img.width);
}

void draw(){
  image(img, 0, 0);
}
