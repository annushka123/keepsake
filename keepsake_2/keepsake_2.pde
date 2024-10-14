import processing.video.Movie;
import oscP5.*;
import netP5.*;
import java.util.Iterator;
import java.util.Random;


OscP5 oscP5;
NetAddress goingToMax;

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
boolean state2Triggered = false; 


// wekinator features
float f1, startingGesture, f3, f4, f5, f6, f7, f8, f9, f10;

//max values
float sb2, sb3 = 0;

void setup() {
  //fullScreen(2);
  size(1200, 800);
  setupOSC();

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

  //mov[currentMovie].play();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {
  if (updateBackground) {
    background(0);  // Set the background initially
  }

  println("Current state: " + currentState);
  
  variousStates();
  
    // Add this to debug when state 2 is reached
  if (currentState == 2) {
    println("Confirmed: Now in State 2");
  }

  if (startingGesture == 2. && previousGesture != 2. && !pieceHasStarted) {
    startThePiece();
    println("startingGesture: ", startingGesture);
    startingState();
    currentState = 0;
  }

  previousGesture = startingGesture;

  //println("sb2: " + sb2);

  if (sb2 > 0. && currentState == 0) {

    currentState = 1;
    //println("currentState is: " + currentState);
  }

  

  if (currentState == 0) {
    //image(mov[currentMovie], 0, 0, width, height);  // Display the first movie

    //// Now apply the pixel subtraction and render the diffFrame
    currentFrame.copy(mov[currentMovie], 0, 0, mov[currentMovie].width, mov[currentMovie].height, 0, 0, width, height);
    currentFrame2.copy(mov[8], 0, 0, mov[8].width, mov[8].height, 0, 0, width, height);

    currentFrame.loadPixels();
    currentFrame2.loadPixels();

    //// Perform pixel subtraction to detect motion differences
    pixelSubtraction(currentFrame, previousFrame, diffFrame );
    pixelSubtraction(currentFrame2, previousFrame2, diffFrame2 );


    //// Render the difference frame on top of everything
    image(diffFrame, 0, 0, width, height);

    // Blend the second movie on top of the first
    blend(diffFrame2, 0, 0, width, height, 0, 0, width, height, ADD);

    //// Update previous frame for the next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame2.copy(currentFrame2, 0, 0, width, height, 0, 0, width, height);


    previousFrame.updatePixels();
    previousFrame2.updatePixels();
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

  if (currentState == 1 && previousState != 0 && selectedMovie == 1) {

    goToSB2a();
    //println("selectedMovie is: " + selectedMovie);
    previousState = state1a;


    
  } else if (currentState == 1 && previousState != 1 && selectedMovie == 2) {

    goToSB2b();
    //println("selectedMovie is: " + selectedMovie);
    previousState = state1b;


  }

  if(currentState == 1 && sb3 > 0. && !state2Triggered) {
    
    
    currentState = 2;
    state2Triggered = true;
    println("gone to state 2");
  }


  if (currentState == 1 || currentState == 3) {

    ps.addParticle();
    ps.run();
  }
}
