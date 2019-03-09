PImage img;

void setup(){
  img = loadImage("hukuoka-tower.jpg");
  size(728, 484);
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
   else{
   flag = false;
   x = 0;
   y = 0;
  }
 }
}
void mouseClicked(){
 flag = true;
}
