

//class PhotoParticles extends Particles {
  
//    // Constructor
//    PhotoParticles(PVector pos) {
//      super(pos);
//  }
  
  
//  //@overrides
//  void display() {
//  for(int i = 0; i < 100; i++) {
//  float x = random(width);
//  float y = random(height);
//  color c = img[currentImage].get(int(x), int(y));
//  fill(c);
//  noStroke();
//  ellipse(x, y, 10, 10);
    
//  }
  
  
//  } 
  
  
//}

//class PhotoParticles extends Particles {
//  color particleColor;  // Color of the particle, sampled from the image

//  // Constructor
//  PhotoParticles(PVector pos, PImage img) {
//    super(pos);  // Initialize the position
//    int x = int(random(img.width));  // Random x position in the image
//    int y = int(random(img.height)); // Random y position in the image
//    particleColor = img.get(x, y);  // Sample the color from the image
//  }

//  // Override the display method to show the ellipse with the sampled color
//  @Override
//  void display() {
//    noStroke();  // No stroke for the particles
//    fill(particleColor);  // Fill the particle with the sampled color
//    ellipse(position.x, position.y, 10, 10);  // Draw a circle with size 10
//  }
//}


void photoParticles() {
  for(int i = 0; i < 100; i++) {
  float x = random(width);
  float y = random(height);
  color c = img[currentImage].get(int(x), int(y));
  fill(c);
  noStroke();
  ellipse(x, y, 10, 10);
  
  }
  
}
