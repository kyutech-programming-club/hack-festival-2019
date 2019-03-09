PImage img;

void setup(){
  img = loadImage("hukuoka-tower.jpg");
  size(728, 484);
  println(img.height);
  println(img.width);
}
int x, y;
boolean flag = false;
void draw(){
  background(0);
  image(img, x, y); 
  if(flag){
   if(img.width - x > 0){
    x += 10;
   }
  }
}
void mouseClicked(){
 flag = true;
}
