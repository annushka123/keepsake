
int unselectedMovie = -1; 

void startingState() {
  switch(currentState) {

  case 0:
    // Play Movie 0
    //background(0);
    pieceHasStarted = true;
    previousGesture = startingGesture;
    currentMovie = 0;
    //println("State 0: Playing Movie 0");
    image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    if (!mov[currentMovie].isPlaying()) {
      mov[currentMovie].play();
      println("Is mov[currentMovie] loaded and playing? " + mov[currentMovie].isPlaying());
    }


    //blend(mov[8], 0, 0, width, height, 0, 0, width, height, ADD);
    //shouldClearBackground = true;
    background(0);
    break;
  }
}


void variousStates() {
  switch(currentState) {
    

  case 1:
  
    //println("Transitioning to State 1, selectedMovie: " + selectedMovie);
    
  
      if (!mov[8].isPlaying()) {
      mov[8].loop();
      println("Is mov[8] loaded and playing? " + mov[8].isPlaying());
    }

    // Randomly choose between Movie 1 and 2
    //if (selectedMovie == -1) {
    //  selectedMovie = rand.nextInt(2) + 1;  // Randomly pick Movie 1 or 2
    //  unselectedMovie = (selectedMovie == 1) ? 2 : 1; 
    //  //println("State 1: Randomly selected Movie " + selectedMovie);
    //  mov[selectedMovie].play();  // Play the randomly selected movie


    //}
    currentMovie = 1;
    if(!mov[currentMovie].isPlaying()) {
      mov[currentMovie].play();
    }

    ////shouldClearBackground = true;
    //      if (selectedMovie == 2) {
    //    println("Selected Movie 2: Forcing background clear.");
    //    background(0);
    //  }
      background(0); // Clear background explicitly
    break;

  case 2:
    // Display particles generated from the current image
    println("State 2: Displaying particles from Image " + currentImage);

    if(mov[8].isPlaying()) {
      mov[8].stop();
    }
     ps.addPhotoParticle();  // Add regular particles

    ps.run();  // Update and display all regular particles

    //ps.run();

    break;

  case 3:
    
        currentMovie = 2; 
        if(!mov[currentMovie].isPlaying()) {
          mov[currentMovie].loop();
        }
        
    println("State 3: Playing Movie " + currentMovie);
      if (!mov[0].isPlaying()) {
      mov[0].play();
      println("Is mov[0] loaded and playing? " + mov[0].isPlaying());
    }
    
    //background(0);
    break;
 

  case 4:
  if(mov[2].isPlaying()) {
    mov[2].stop();
  }
      if (!mov[7].isPlaying()) {
      mov[7].loop();
      println("Is mov[7] loaded and playing? " + mov[7].isPlaying());
    }
    // Return to Movie 0
    currentMovie = 0;
    if(!mov[currentMovie].isPlaying()) {
    mov[currentMovie].loop();  // Ensure Movie 0 plays again
    println("State 4: Returning to Movie 0");
    
    }
    //image(mov[currentMovie], 0, 0, width, height);  // Display the movie
    
   //background(0);
    break;
  }
}





void keyPressed() {
  
  if (key == '2') {  // Manually trigger state 2
        currentState = 2;
        state2Triggered = true;
        println("Manually transitioned to State 2");

        // Call any additional setup or actions you want when state 2 is manually triggered
        autoCycleImages();  // If needed, trigger image cycling manually
        

          
    }
    
    if (key == '4') {  // Manually trigger state 4
        currentState = 4;
        state4Triggered = true;
        println("Manually transitioned to State 4");
    }
}


void photoBackground() {

  fill(0);
  rect(0, 0, width, height);
}
