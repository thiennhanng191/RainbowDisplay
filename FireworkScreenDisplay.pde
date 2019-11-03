/**
 * A Firework Screen Display
 * @author Nhan Nguyen
 * @version CMPU-203-01
 *
 * Display fireworks on the screen
 * Enable users to change the fireworks' colors based on 
 * the 6 basic hue color ranges (red, yellow, green, cyan, blue, magenta).
 * Also let users change the emission rate of the fireworks by 
 * left-click or right-click on mouse. 
 * Instructions can be found be hovering the mouse over the '?' button on the screen
*/
import java.util.*; 

int parNum; 
int keyID = 0; 
float emitRate = 0.05;

int textBoxWidth = 350;
int textBoxHeight = 50;

boolean noEmission = false;

boolean mouseHovering = false; 

List<Firework> fireworks = new ArrayList<Firework>(); 

boolean clickMouse = false; 

float circleRadius = 45; 
float circlePosX; 
float circlePosY;

void setup() {
  size(600, 600);
  colorMode(HSB, 360, 100, 100, 100);
  stroke(255); 
  strokeWeight(4); 

  smooth(); //anti-alias -> help render better
  background(color(0, 0, 0, 100));
  circlePosX = 0.92 * width; 
  circlePosY = 0.08 * height;
}

void draw() {
  noStroke();
  fill(0, 0, 0, 20); //in HSB - hue, saturation, brightness. last param is alpha (opacity)
  rect(0, 0, width, height); //creating the tail effects for the firework
  
  fill(0, 0, 20, 100); 
  circle(circlePosX, circlePosY, circleRadius); 
  fill(255); 
  textAlign(CENTER, CENTER); 
  textSize(28); 
  text("?", circlePosX+1, circlePosY-3);
  
 
  mouseHovering = dist(mouseX, mouseY, circlePosX, circlePosY) <= circleRadius/2; 
  // hover around the '?' button to display the helper text box
  if (mouseHovering) {
    fill(0, 0, 20, 100); 
    rect(circlePosX - 4*circleRadius - textBoxWidth/1.4, circlePosY + 2*circleRadius - 1.2*textBoxHeight, 1.8*textBoxWidth, 4.6*textBoxHeight); 
    fill(255); 
    textAlign(LEFT, CENTER); 
    textSize(12); 
    
    String helper = ("To change fireworks' colors:\n"); 
    helper += ("Press 'r' or 'R' to change the fireworks' colors to those in the red palette\n");
    helper += ("Press 'y' or 'Y' to change the fireworks' colors to those in the yellow palette\n"); 
    helper += ("Press 'g' or 'G' to change the fireworks' colors to those in the green palette\n"); 
    helper += ("Press 'c' or 'C' to change the fireworks' colors to those in the cyan palette\n"); 
    helper += ("Press 'b' or 'B' to change the fireworks' colors to those in the blue palette\n"); 
    helper += ("Press 'm' or 'M' to change the fireworks' colors to those in the magenta palette\n"); 
    helper += ("Press any other key besides 'q' or 'Q' to have the most colorful fireworks' display\n"); 
    helper += ("To change emission rate:\n"); 
    helper += ("Left-click on mouse to increase emission rate\n"); 
    helper += ("Left-click on mouse to decrease emission rate\n"); 
    helper += ("To exit, press 'q' or 'Q'. Enjoy!\n"); 

   text(helper, circlePosX - 9.45*circleRadius, circlePosY + 3.4*circleRadius);
  }
  if (noEmission) { //print user-friendly error message when there is no fireworks emitted
    fill(0, 0, 20, 100); 
    rect(width/2 - textBoxWidth/2, height/2 - textBoxHeight/2, textBoxWidth, textBoxHeight); 
    fill(255); 
    textAlign(CENTER, CENTER); 
    textSize(12); 
    text("No firework emitted! \n Please increase emission rate by left click on mouse", width/2, height/2);
  } 

  if (random(1) < emitRate) //determining rate of emission
    fireworks.add(new Firework()); 

  for (int i = fireworks.size() - 1; i >= 0; i--) {
    fireworks.get(i).update(); 
    fireworks.get(i).show();
    if (fireworks.get(i).done()) {
      fireworks.remove(i); //clean the array to maintain the program's performance
    }
  }
}

/**
* method handling the key events of the program
* match key input to keyID to change the fireworks color based on the 6 main hue values.
*/
void keyReleased() {
  switch(key) {
  case 'r': 
  case 'R': 
    keyID = 1; 
    break; 
  case 'y': 
  case 'Y': 
    keyID = 2; 
    break;
  case 'g': 
  case 'G': 
    keyID = 3; 
    break; 
  case 'c': 
  case 'C': 
    keyID = 4; 
    break; 
  case 'b': 
  case 'B': 
    keyID = 5; 
    break; 
  case 'm': 
  case 'M': 
    keyID = 6; 
    break;
  case 'q':
  case 'Q':
    exit(); 
  default: 
    keyID = 0;
  }
}

/**
* method handling the mouse events of the program
* increase or decrease the fireworks' emission rate if user
* left-click or right-click on mouse respectively
*/
void mouseReleased() {
  if (mouseButton == LEFT) {
    emitRate += 0.05;
    if (emitRate > 0){
    noEmission = false;  
    }
  } else if (mouseButton == RIGHT) {
    emitRate -= 0.05; 
    if (emitRate <= 0) {
      print("No firework emitted"); 
      noEmission = true; 
    } 
  }
}
