import processing.video.Movie;
import oscP5.*;
import netP5.*;
import java.util.Iterator;
import java.util.Random;

Movie[] mov = new Movie[3];
PImage[] img = new PImage[11];

boolean videoStarted = false;
boolean videoStopped = false;

int currentMovie = 0;
int currentState = 0;
int currentImage = 0;
int selectedMovie = -1;  // To remember which movie was chosen (1 or 2)
Random rand = new Random();

OscP5 oscP5;
NetAddress dest;

// wekinator features
float f1, f2, f3, f4, f5, f6, f7, f8, f9, f10;

void setup() {
  // fullScreen(2);
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
      // Play Movie 0
      currentMovie = 0;
      image(mov[currentMovie], 0, 0, width, height);
      break;
      
    case 1:
      // Randomly choose between Movie 1 and 2
      if (selectedMovie == -1) {
        selectedMovie = rand.nextInt(2) + 1;  // Randomly pick Movie 1 or 2
        mov[selectedMovie].play();  // Play the randomly selected movie
      }
      currentMovie = selectedMovie;
      image(mov[currentMovie], 0, 0, width, height);
      break;
      
    case 2:
      // Cycle through images
      image(img[currentImage], 0, 0, width, height);
      break;
      
    case 3:
      // Play the movie that wasn't chosen in case 1
      currentMovie = (selectedMovie == 1) ? 2 : 1;
      mov[currentMovie].play();  // Play the other movie
      image(mov[currentMovie], 0, 0, width, height);
      break;
      
    case 4:
      // Return to Movie 0
      currentMovie = 0;
      mov[currentMovie].play();  // Ensure Movie 0 plays again
      image(mov[currentMovie], 0, 0, width, height);
      break;
  }
}

// Use key press to trigger transitions between states
void keyPressed() {
  if (key == 'n') {  // 'n' moves to the next state
    currentState++;
    
    if (currentState == 2) {
      // Stop any movie when transitioning to images
      mov[currentMovie].stop();
    } else if (currentState == 3) {
      // Play the movie that wasn't chosen after the images
      mov[currentMovie].play();
    } else if (currentState > 4) {
      // Reset the performance after going through all states
      currentState = 0;
      selectedMovie = -1;  // Reset movie selection
      mov[currentMovie].play();
    }
  } else if (key == 'i') {  // 'i' cycles through images in state 2
    if (currentState == 2) {
      currentImage = (currentImage + 1) % img.length;
    }
  }
}
