import de.voidplus.leapmotion.*;

LeapMotion leap;

void setup(){
  leap = new LeapMotion(this); 
  size(800, 800, P3D);
  rotate(PI/4);
  background(255);
  fill(0);
}

void draw(){
  background(255);
  lights();
  int hand_num   = leap.countHands();
  int finger_num = leap.countFingers();
  
  println("Hand num : " + hand_num);
  println("Finger num : " + finger_num);
  
  for (Hand hand : leap.getHands())
  {
    if (hand.isRight())
    {
      println("Right hand detected.");
    }
    else 
    {
      println("Left hand detected.");      
    }
  }
  
  for (Hand hand : leap.getHands())
  {
    for (Finger finger : hand.getFingers())
    {
      println(finger.getBone(3).getNextJoint().x);
      pushMatrix();
      translate(finger.getBone(3).getNextJoint().x,
                finger.getBone(3).getNextJoint().y,
                finger.getBone(3).getNextJoint().z);
      fill(120);
      sphere(10);
      popMatrix();
      finger.drawBones();
      finger.drawJoints();
      
    }
    
  }
}

void leapOnInit(){
  println("hello");
}
