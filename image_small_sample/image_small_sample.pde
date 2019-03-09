PImage img;

void setup(){
  img = loadImage("hukuoka-tower.jpg");
  size(728, 484);
  imageMode(CENTER);
  println(img.height);
  println(img.width);
}
int x = 728/2;
int y = 484/2;
float size_plm_x = 728.0;
float size_plm_y = 484.0;
boolean has_clicked = false;
void draw(){
  background(255);
  if(size_plm_x > 0 && size_plm_y > 0){
    image(img, x, y);
  }
  if(has_clicked){
   if(y > -484/2){
     size_plm_x *= 0.9;
     size_plm_y *= 0.9;
     if(int(size_plm_x) > 0 && int(size_plm_y) > 0){
        img.resize(int(size_plm_x), int(size_plm_y));
     }
    y -= 10;
   }
  }
}
void mouseClicked(){
  has_clicked = true;
}
