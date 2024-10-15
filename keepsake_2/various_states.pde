
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
    updateBackground = true;
    // Play the movie that wasn't chosen in case 1
    currentMovie = unselectedMovie; 
    println("State 3: Playing Movie " + currentMovie);
    mov[currentMovie].play();  // Play the other movie
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    break;
    

  case 4:
    // Return to Movie 0
    currentMovie = 0;
    if(!mov[0].isPlaying()) {
    mov[currentMovie].play();  // Ensure Movie 0 plays again
    println("State 4: Returning to Movie 0");
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    }
    break;
  }
}


//void keyPressed() {
//  if (key == 'n') {  // 'n' moves to the next state
//    currentState++;
//    if (currentState > 4) {
//      currentState = 0;  // Loop back to State 0
//    }
//    handleStateChange();
//  } else if (key == 'p') {  // 'p' moves to the previous state
//    currentState--;
//    if (currentState < 0) {
//      currentState = 4;  // Loop back to State 4
//    }
//    handleStateChange();
//  }
//}

//void handleStateChange() {
//  println("Transitioning to State: " + currentState);

//  // Handle state-specific logic during transitions
//  switch (currentState) {
//    case 0:  // Starting state logic
//      startingState();  // Play Movie 0 and set up initial state
//      break;

//    case 1:
//      // Logic for playing random movie between Movie 1 and 2
//      if (selectedMovie == -1) {
//        selectedMovie = rand.nextInt(2) + 1;  // Randomly pick Movie 1 or 2
//        mov[selectedMovie].play();
//      }
//      println("State 1: Playing Movie " + selectedMovie);
//      break;

//    case 2:  // Cycling through images and running particles
//      println("State 2: Displaying particles from Image " + currentImage);
//      autoCycleImages();  // Start cycling images
//      ps.addPhotoParticle();
//      ps.run();
//      break;

//    case 3:  // Playing the other movie not chosen in State 1
//      currentMovie = (selectedMovie == 1) ? 2 : 1;
//      println("State 3: Playing Movie " + currentMovie);
//      ps.clear();  // Clear particles from State 2
//      mov[currentMovie].play();
//      break;

//    case 4:  // Reset to Movie 0
//      currentMovie = 0;
//      mov[currentMovie].play();
//      println("State 4: Returning to Movie 0");
//      break;

//    default:
//      println("Unknown state: " + currentState);
//      break;
//  }
//}




void photoBackground() {

  fill(0);
  rect(0, 0, width, height);
}
