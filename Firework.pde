/**
* Class representing a Firework
* @author Nhan Nguyen
* @version CMPU-203-01
*/
class Firework {
  color particleColor = color(random(0, 360), 100, 100);

  List<Particle> particles = new ArrayList<Particle>(); 

  Particle firework;

  boolean fireworkExist = true; 
  boolean fireworkExploded = false; 
  
  /**
  * Empty constructor for a firework (get colors based on user key handling)
  * The 6 colors are the 6 main range of hue values in HSB
  */
  Firework() {
    switch (keyID){
      case 1: 
      particleColor = color(random(0, 60), 100, 100); //red palette
      break; 
      case 2:
      particleColor = color(random(61, 120), 100, 100); //yellow palette
      break; 
      case 3:
      particleColor = color(random(121, 180), 100, 100); //green palette
      break; 
      case 4:
      particleColor = color(random(181, 240), 100, 100); //cyan palette
      break; 
      case 5:
      particleColor = color(random(241, 300), 100, 100); //blue palette
      break; 
      case 6:
      particleColor = color(random(301, 360), 100, 100); //magenta palette
      break; 
      case 0: 
      particleColor = color(random(0, 360), 100, 100); //all colors
     }
    firework = new Particle(random(width), height, particleColor, true); 
    }
 

  /**
  * Method checking if a firework has already gone
  * @return ture if a firework has disappeared, false otherwise
  */
  boolean done() {
    if (fireworkExploded && particles.size() == 0)
      return true; 
    else 
    return false;
  }
  
  /**
  * Method updating fireworks motion
  */
  void update() {

    if (!fireworkExploded) {
      firework.applyGravity(); 
      firework.update();

      if (firework.g >= Math.abs(firework.dy)) { // check max height of particle to explode
        fireworkExploded = true;
        explode();
      }
    }

    for (int i = particles.size() - 1; i >= 0; i--) { 
      particles.get(i).applyGravity(); 
      particles.get(i).update(); 
      if (particles.get(i).done()) {
        particles.remove(i); //remove item to keep array size small to maintain program's performance
      }
    }
  }

  /**
  * Method to construct a fireworks' explosion.
  */
  void explode() {
    for (int i = 0; i < 360; i++) { 
      Particle explodePar = new Particle(firework.xPos, firework.yPos, particleColor, false); 
      particles.add(explodePar);
    }
  }

  /**
  *  Method to display a firework
  */
  void show() {
    if (!fireworkExploded) {
      firework.show();
    }

    for (int i = 0; i < particles.size(); i++) { 
      particles.get(i).show();
    }
  }
}
