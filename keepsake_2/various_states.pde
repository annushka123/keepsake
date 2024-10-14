
int unselectedMovie = -1; 

void startingState() {
  switch(currentState) {

  case 0:
    // Play Movie 0

    pieceHasStarted = true;
    previousGesture = startingGesture;
    currentMovie = 0;
    //println("State 0: Playing Movie 0");
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    if (!mov[currentMovie].isPlaying()) {
      mov[currentMovie].play();
      println("Is mov[currentMovie] loaded and playing? " + mov[currentMovie].isPlaying());
    }
    //currentMovie = 8;
    if (!mov[8].isPlaying()) {
      mov[8].loop();
      println("Is mov[8] loaded and playing? " + mov[8].isPlaying());
    }

    //blend(mov[8], 0, 0, width, height, 0, 0, width, height, ADD);

    break;
  }
}


void variousStates() {
  switch(currentState) {
  case 1:

    // Randomly choose between Movie 1 and 2
    if (selectedMovie == -1) {
      selectedMovie = rand.nextInt(2) + 1;  // Randomly pick Movie 1 or 2
      unselectedMovie = (selectedMovie == 1) ? 2 : 1; 
      //println("State 1: Randomly selected Movie " + selectedMovie);
      mov[selectedMovie].play();  // Play the randomly selected movie
    }
    currentMovie = selectedMovie;
    //println("State 1: Playing Movie " + currentMovie);
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    break;

  case 2:
    // Display particles generated from the current image
    println("State 2: Displaying particles from Image " + currentImage);
    //image(img[currentImage], 0, 0, width, height);
    //mov[currentMovie].stop();
    updateBackground = false;
    //photoParticles();
    ps.addPhotoParticle();

    ps.run();

    break;

  case 3:

    // Play the movie that wasn't chosen in case 1
    currentMovie = unselectedMovie; 
    println("State 3: Playing Movie " + currentMovie);
    mov[currentMovie].play();  // Play the other movie
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    break;
    
  }
}

void endingState() {
switch(currentState) {
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
  if (key == 'n' && currentState == 2) {  // Move to state 3 from 2
    currentState = 3;
    println("Transitioned to State 3");
  }

  if (key == 'i' && currentState == 2) {  // Cycle through images in state 2
    currentImage = (currentImage + 1) % img.length;
    println("State 2: Cycling through images. Current image: " + currentImage);
  }

  if (key == 'r') {  // Reset everything for testing
    currentState = 0;
    state2Triggered = false;  // Reset flags
    println("Reset to State 0");
  }
}


void photoBackground() {

  fill(0);
  rect(0, 0, width, height);
}
