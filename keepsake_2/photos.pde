
int imageChangeDuration = 6000;
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
      //velocity = new PVector(0, 0.01); 
      
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
  
      void update() {
        // Apply forces to the particle's actual position
        velocity.add(acceleration);  // Velocity affected by acceleration
        position.add(velocity);      // Position affected by velocity
        acceleration.mult(0);        // Reset acceleration after each update

        // The lifespan decreases to make the particle "die" over time (if needed)
        lifespan -= 2.0;
    }
  
  //@overrides
//void display() {
//    // Use the actual position of the particle (p.position) instead of random positions
//    float x = position.x;
//    float y = position.y;
//    //for(int i = 0; i < 100; i++) {
//    // Get the color from the image based on the particle's current position
//    if (x >= 0 && x < width && y >= 0 && y < height) {  // Ensure position is within bounds
//        color c = img[currentImage].get(int(x), int(y));  // Get color from the current image
//        fill(c);
//        noStroke();
//        ellipse(x, y, 30, 30);  // Draw the particle based on its actual position
    
//    }
//}

  
  
  
  
  
}


//void photoParticles() {
//  for(int i = 0; i < 100; i++) {
//  float x = random(width);
//  float y = random(height);
//  color c = img[currentImage].get(int(x), int(y));
//  fill(c);
//  noStroke();
//  ellipse(x, y, 10, 10);
  
//  }
  
//}
