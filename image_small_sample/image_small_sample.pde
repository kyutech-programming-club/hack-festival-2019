PImage img;

void settings(){
  img = loadImage("hukuoka-tower.jpg");
  size(img.width, img.height);
}

int x, y;
float size_plm_x, size_plm_y;
boolean has_clicked;

void setup(){
  imageMode(CENTER);
  x = width/2;
  y = height/2;
  size_plm_x = width;
  size_plm_y = height;
  has_clicked = false;
}

void draw(){
  background(255);
  if(size_plm_x > 0 && size_plm_y > 0){
    image(img, x, y);
  }
  if(has_clicked){
   if(y > -y){
     size_plm_x *= 0.9;
     size_plm_y *= 0.9;
     if(int(size_plm_x) > 0 && int(size_plm_y) > 0){
        img.resize(int(size_plm_x), int(size_plm_y));
     }
    y -= 10;
   }
   else{
    has_clicked = false;
    y = height/2;
    size_plm_x = width;
    size_plm_y = height;
    img = loadImage("hukuoka-tower.jpg");
   }
  }
}
void mouseClicked(){
  has_clicked = true;
}
