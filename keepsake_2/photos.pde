
int imageChangeDuration = 3000;
int lastImageChangeDuration = 0;

void autoCycleImages() {
  
  if(millis() - lastImageChangeDuration >= imageChangeDuration) {
    
    currentImage = (currentImage + 1) % img.length;
    
    lastImageChangeDuration = millis();
    
  }
  
  
  //image(img[currentImage], 0, 0, width, height);

}
class PhotoParticles extends Particles {
  
    // Constructor
    PhotoParticles(PVector pos) {
      super(pos);
      acceleration = new PVector(0, 0.0); 
      
  }
  
  
  //@overrides
  void display() {
  for(int i = 0; i < 10; i++) {
  float x = random(width);
  float y = random(height);
  color c = img[currentImage].get(int(x), int(y));
  fill(c);
  noStroke();
  ellipse(x, y, 10, 10);
    
  }
  
  
  } 
  
  
}

//class PhotoParticles extends Particles {
//  color particleColor;  // Color of the particle, sampled from the image

//  // Constructor
//  PhotoParticles(PVector pos, PImage img[]) {
//    super(pos);  // Initialize the position
//    velocity = new PVector(0, 0);  // Random velocity to start
//    //acceleration = new PVector(0, 0.0); 
//    int x = int(random(width));  // Random x position in the image
//    int y = int(random(height)); // Random y position in the image
//    particleColor = img[currentImage].get(x, y);  // Sample the color from the image
//  }

//  // Override the display method to show the ellipse with the sampled color
//  @Override
//  void display() {
//    noStroke();  // No stroke for the particles
//    fill(particleColor);  // Fill the particle with the sampled color
//    ellipse(position.x, position.y, 50, 50);  // Draw a circle with size 10
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
