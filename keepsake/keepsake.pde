import processing.video.Movie;
import oscP5.*;
import netP5.*;
import java.util.Iterator;
import java.util.Random;

Movie[] mov = new Movie[4];
int currentMovie = 0;
boolean videoStarted = false;
boolean videoStopped = false;

PImage[] img = new PImage[11];
int currentState = 0;
int currentImage = 0;

OscP5 oscP5;
NetAddress dest;

//wekinator features
float f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;

void setup() {
  //fullScreen(2);
  size(1200, 800);

  for (int i = 0; i < img.length; i++) {
    img[i] = loadImage("photo" + i + ".jpg");
    img[i].resize(width, height);
    img[i].loadPixels();
  }

  for (int i = 0; i < mov.length; i++) {
    mov[i] = new Movie(this, "music_box" + i + ".mp4");
  }

  mov[currentMovie].play();
}

void movieEvent(Movie m) {
  m.read();
}

void draw() {

  background(0);




  variousStates();
}

void variousStates() {
  switch (currentState) {
  case 0:
    if (mov[currentMovie] != null) {
      if (currentMovie == 3) {

        pushMatrix();
        translate(width, 0);
        rotate(PI/2);

        image(mov[currentMovie], 0, 0, height, width);

        popMatrix();
      } else {
        image(mov[currentMovie], 0, 0, width, height);
      }
    }
    break;

  case 1:
    if (img[currentImage] != null) {
      image(img[currentImage], 0, 0, width, height);
    }
    break;
  }
}


// Use key press to control state and cycling
void keyPressed() {
  if (key == 'm') {  // 'm' switches to movie state
    if (currentState != 0) {
      currentState = 0;  // Switch to movie state
      mov[currentMovie].play();  // Play current movie
    }
  } else if (key == 'i') {  // 'i' switches to image state
    if (currentState != 1) {
      currentState = 1;  // Switch to image state
      mov[currentMovie].stop();  // Stop current movie if switching from movie state
    }
  } else if (key == 'n') {  // 'n' to cycle to next movie or image
    if (currentState == 0) {  // Cycling through movies
      mov[currentMovie].stop();  // Stop current movie
      currentMovie = (currentMovie + 1) % mov.length;  // Move to next movie
      mov[currentMovie].play();  // Play the next movie
    } else if (currentState == 1) {  // Cycling through images
      currentImage = (currentImage + 1) % img.length;  // Move to next image
    }
  }
}
