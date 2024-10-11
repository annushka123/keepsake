import processing.video.Movie;
import oscP5.*;
import netP5.*;
import java.util.Iterator;
import java.util.Random;

Movie[] mov = new Movie[10];
PImage[] img = new PImage[11];
PImage  currentFrame, previousFrame, diffFrame;
PImage  currentFrame2, previousFrame2, diffFrame2;


ParticleSystem ps;

boolean videoStarted = false;
boolean videoStopped = false;

int currentMovie = 0;
int currentState = 0;
int currentImage = 0;
int selectedMovie = -1;  // To remember which movie was chosen (1 or 2)
Random rand = new Random();
int thresholdValue = 40;  // Sensitivity for pixel subtraction

boolean updateBackground = true;  // Flag to control background
OscP5 oscP5;
NetAddress dest;

// wekinator features
float f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;

void setup() {
  //fullScreen(2);
  size(1200, 800);

  ps = new ParticleSystem();



  for (int i = 0; i < img.length; i++) {
    img[i] = loadImage("photo" + i + ".jpg");


    if (img[i] != null) {
      img[i].resize(width, height);
      img[i].loadPixels();
      //convertToGrayscale(img[i]);
      img[i].updatePixels();
    } else {
      println("Image " + i + " failed to load.");
    }
  }




  for (int i = 0; i < mov.length; i++) {
    mov[i] = new Movie(this, "keepsake" + i + ".mp4");
  }
  // Prepare images to hold frame data
  currentFrame = createImage(width, height, RGB);
  previousFrame = createImage(width, height, RGB);
  diffFrame = createImage(width, height, RGB);
  
  currentFrame2 = createImage(width, height, RGB);
  previousFrame2 = createImage(width, height, RGB);
  diffFrame2 = createImage(width, height, RGB);

  mov[currentMovie].play();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  if (updateBackground) {
    background(0);  // Set the background initially
  }




    variousStates();
  
    if (currentState == 0) {
    image(mov[currentMovie], 0, 0, width, height);  // Display the first movie

    //// Now apply the pixel subtraction and render the diffFrame
    currentFrame.copy(mov[currentMovie], 0, 0, mov[currentMovie].width, mov[currentMovie].height, 0, 0, width, height);
    currentFrame2.copy(mov[8], 0, 0, mov[8].width, mov[8].height, 0, 0, width, height);
    
    currentFrame.loadPixels();
    currentFrame2.loadPixels();

    //// Perform pixel subtraction to detect motion differences
    pixelSubtraction(currentFrame, previousFrame, diffFrame );
    pixelSubtraction(currentFrame2, previousFrame2, diffFrame2 );


    //// Update previous frame for the next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame2.copy(currentFrame2, 0, 0, width, height, 0, 0, width, height);
    
    
    previousFrame.updatePixels();
    previousFrame2.updatePixels();  
    
       
    //// Render the difference frame on top of everything
    image(diffFrame, 0, 0, width, height);
    
    // Blend the second movie on top of the first
    blend(diffFrame2, 0, 0, width, height, 0, 0, width, height, ADD);
  }


  //// Only process pixel subtraction and diffFrame when you're in a movie-playing state (0, 1, 3, 4)
  if (currentState == 1 || currentState == 3 || currentState == 4) {
    currentFrame.copy(mov[currentMovie], 0, 0, mov[currentMovie].width, mov[currentMovie].height, 0, 0, width, height);
    currentFrame.loadPixels();

    // Process the current frame to detect differences (outline)
    pixelSubtraction(currentFrame, previousFrame, diffFrame );

    // Display the processed frame (video difference outline)
    image(diffFrame, 0, 0, width, height);

    // Save current frame as previous frame for next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame.updatePixels();
  }

  if (currentState == 1 || currentState == 3) {

    ps.addParticle();
    ps.run();
  }


}

void variousStates() {
  switch (currentState) {
  case 0:
    // Play Movie 0

    currentMovie = 0;
    //println("State 0: Playing Movie 0");
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    
    //currentMovie = 8;
    if(!mov[8].isPlaying()) {
    mov[8].play();
    println("Is mov[8] loaded and playing? " + mov[8].isPlaying());

    }
    //blend(mov[8], 0, 0, width, height, 0, 0, width, height, ADD); 

    break;

  case 1:

    // Randomly choose between Movie 1 and 2
    if (selectedMovie == -1) {
      selectedMovie = rand.nextInt(2) + 1;  // Randomly pick Movie 1 or 2
      println("State 1: Randomly selected Movie " + selectedMovie);
      mov[selectedMovie].play();  // Play the randomly selected movie
    }
    currentMovie = selectedMovie;
    println("State 1: Playing Movie " + currentMovie);
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    break;

  case 2:
    // Display particles generated from the current image
    println("State 2: Displaying particles from Image " + currentImage);
    //image(img[currentImage], 0, 0, width, height);

    updateBackground = false;
    //photoParticles();
    ps.addPhotoParticle();
    
    ps.run();
    
    break;

  case 3:
    
    // Play the movie that wasn't chosen in case 1
    currentMovie = (selectedMovie == 1) ? 2 : 1;
    println("State 3: Playing Movie " + currentMovie);
    mov[currentMovie].play();  // Play the other movie
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    break;

  case 4:
    // Return to Movie 0
    currentMovie = 0;
    mov[currentMovie].play();  // Ensure Movie 0 plays again
    println("State 4: Returning to Movie 0");
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    break;
  }
}


void keyPressed() {
  if (key == 'n') {  // 'n' moves to the next state
    currentState++;

    if (currentState == 2) {
      println("Transitioning to State 2: Stopping Movie " + currentMovie);
      mov[currentMovie].stop();  // Stop the current movie when switching to particles
    } else if (currentState == 3) {
      println("Transitioning to State 3: Playing the other movie");
      mov[currentMovie].play();  // Play the movie that wasn't chosen after particles
    } else if (currentState > 4) {
      println("Resetting to State 0");
      currentState = 0;
      selectedMovie = -1;  // Reset the selected movie
      mov[currentMovie].play();
    }
  } else if (key == 'i') {  // 'i' cycles through images in state 2
    if (currentState == 2) {
      currentImage = (currentImage + 1) % img.length;  // Cycle through images
      println("State 2: Cycling through images. Current image: " + currentImage);
    }
  }
}

void photoBackground() {

  fill(0);
  rect(0, 0, width, height);
}
