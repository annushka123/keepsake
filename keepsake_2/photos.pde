
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
