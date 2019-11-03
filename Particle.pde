/**
* Class representing a Particle of a Firework
* @author Nhan Nguyen
* @version CMPU-203-01
*/
class Particle { 
  int size; 
  float xPos;
  float yPos;
  color c;

  int lifespan = 255; 

  float dx = random(random(-12, -1), random(1, 12)); //random the range of random to avoid the firework ending up in square shape
  float dy = random(random(-12, -1), random(1, 12)); 
  float g = 2;

  int upwardsVel = -17; 
  
  boolean notExploded; 

  /**
  * Constructor for a particle of a firework
  * @param x a float representing the x-coordinate of the particle
  * @param y a float representing the y-coordinate of the particle
  * @param c the particle's color
  * @param notExploded true if a particle has not been exploded yet, else otherwise
  */
  Particle(float x, float y, color c, boolean notExploded) {
    xPos = x; 
    yPos = y;
    this.c = c;
    this.notExploded = notExploded;
  }

  /**
  * Method updating a particle's motion
  */
  void update() {
    if (notExploded) {
      yPos += upwardsVel;
      g += 0.15;
    } else {
      xPos += dx;
      yPos += dy;
      dx *= 0.8; //slow down the fireworks' particles after exploded to create mesmerizing effects
      dy *= 0.8; 
      lifespan -=4;
    }
  }
  
  /*
  * Method displaying a particle
  */
  void show() {
    if (!notExploded) {
      stroke(c, lifespan); 
      strokeWeight(2);
    } else {
      stroke(c); 
      strokeWeight(4);
    }
    point(xPos, yPos);
  }
  
  /*
  * Method applying gravity to the particle
  */
  void applyGravity() {
    yPos += g;
  }

  /*
  * Method checking is a particle is still displaying or has disappeared
  * @return true if a particle has disappereared (outlive its livespan)
  * else otherwise
  */
  boolean done() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
} 
