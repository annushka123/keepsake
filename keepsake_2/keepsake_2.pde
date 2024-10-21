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
boolean state4Triggered = false;
boolean hasState2Started = false;
boolean hasState3Started = false;
boolean shouldClearBackground = false;


int currentMovie = 0;
int currentState = 0;
int currentImage = 0;
int selectedMovie = -1;  // To remember which movie was chosen (1 or 2)
Random rand = new Random();
int thresholdValue = 40;  // Sensitivity for pixel subtraction

boolean updateBackground = true;  // Flag to control background
boolean state2Triggered = false;

float alphaIncrease = 0;
float alphaDecrease = 130;
float alphaTarget = 0;  // New variable for the target alpha
float easingFactor = 0.5;

float gravityForce;
float windForce;
float speedMultiplier;
PVector gravity;
PVector wind;


int startTime;  
int counter; 


void setup() {
  fullScreen(2);
  //size(display.width, display.height);
  //size(1000, 600);
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
    //mov[i].loop();
    //  mov[i].pause();
  }
  // Prepare images to hold frame data
  currentFrame = createImage(width, height, RGB);
  previousFrame = createImage(width, height, RGB);
  diffFrame = createImage(width, height, RGB);

  currentFrame2 = createImage(width, height, RGB);
  previousFrame2 = createImage(width, height, RGB);
  diffFrame2 = createImage(width, height, RGB);

  startTime = millis();  // Record the time when the counter starts
  counter = 0; 
}

void movieEvent(Movie m) {
  m.read();
  //m.play();
}

void draw() {
  
   gravityForce = map(vert_pos, 4, 1, -0.3, 0.3);
   windForce = map(vert_pos, 1, 4, -0.2, 0.2);
   speedMultiplier = map(vol, 1, 3, 0.5, 1.5);


// Create the gravity vector based on the mapped force
   gravity = new PVector(0, gravityForce);
   wind = new PVector(windForce*3, 0);
   
  // Set the background initially
  //if (updateBackground) {
  //  background(0);
  //}
  
      if (shouldClearBackground) {
        background(0);
        shouldClearBackground = false; // Reset the flag after clearing
    }



        



  //starts the piece
  if (startingGesture == 2. && previousGesture != 2. && !pieceHasStarted) {
    
    startThePiece();
    println("startingGesture: ", startingGesture);
    startingState();
    currentState = 0;
  }

  previousGesture = startingGesture;

  variousStates();
  //photoBackground();

  //goes from state 0 to state 1
  if (sb2 == 1. && currentState == 0) {
    
    currentState = 1;
    
    
    
    
     if (mov[0].isPlaying()) {
      mov[0].stop();
      println("Is mov[0] loaded and playing? " + mov[0].isPlaying());
  
    }


  }

  //matches two optional videos with their melodies in max
  if (currentState == 1 && previousState != 0 && selectedMovie == 1) {
    
        //shouldClearBackground = true;
    
    println("background: " + shouldClearBackground);

   goToSB2a();
    previousState = state1a;
    println("playing movie 1");
    

    
} else if (currentState == 1 && previousState != 1 && selectedMovie == 2) {

    goToSB2b();
    //println("selectedMovie is: " + selectedMovie);
    previousState = state1b;
    println("playing movie 2");


  
  }
  




  //goes to state 2 (images)
if (currentState == 1 && sb3 == 1. && !state2Triggered) {
    currentState = 2;
    state2Triggered = true;

}

// Ensure state 2 logic is executed when active
if (currentState == 2) {
    //println("Confirmed: Now in State 2");
            if (!hasState2Started) {
            startTime = millis();  // Set start time once when entering State 2
            counter = 0;           // Reset the counter
            hasState2Started = true;  // Mark that State 2 has started
        }

        // Update and display the counter based on elapsed time
        counter = (millis() - startTime) / 1000;
        println("Counter: " + counter + " sec");

        // Condition to play the bell, only once when counter reaches 3 seconds
        if (counter == 1 || counter == 30 && previousBell != 1) {
            playBell_1();  // Call the function to play the bell
            previousBell = bell_1;
        } 
        
                if (counter == 12 && previousBell != 2) {
            playGroan_1();  // Call the function to play the bell
            previousBell = groan_1;
        }
        
                if (counter == 27 && previousBell != 3) {
            playGroan_2();  // Call the function to play the bell
            previousBell = groan_2;
        }
        
                if (counter == 40 && previousBell != 4) {
            playGroan_3();  // Call the function to play the bell
            previousBell = groan_3;
        }
        
                if (counter == 55 && previousBell != 5) {
            playGroan_4();  // Call the function to play the bell
            previousBell = groan_4;
        }
        
                if (counter == 65 && previousBell != 6) {
            playDoni_2();  // Call the function to play the bell
            previousBell = doni_2;
        }

    autoCycleImages();  // Automatically cycle through images
    println("State 2: Cycling through images. Current image: " + currentImage);
    
    for (int i = ps.particles.size() - 1; i >= 0; i--) {  // Iterate backward through the list
    Particles p = ps.particles.get(i);  // Get the particle at index i
    if (p instanceof Particles && !(p instanceof PhotoParticles)) {  // Check if it's a regular particle
        ps.particles.remove(i);  // Remove it from the list
    }
}
   
    for (Particles p : ps.particles) {
    if (p instanceof PhotoParticles) {
      p.applyForce(wind);  
      p.applyForce(gravity);
    }
  }
  
    ps.addPhotoParticle();
    ps.run(); 

    // Only call startML() once when entering state 2
    if (previousState2 != 6) {
        startML();
        previousState2 = generate;
    }


    
    if(currentImage == 2 || currentImage == 7 || currentImage == 11) {
    
      
      mov[5].play();
    
    if (mov[6].isPlaying()) {
    mov[6].pause();
    }  
    
    currentFrame.copy(mov[5], 0, 0, mov[5].width, mov[5].height, 0, 0, width, height);

    currentFrame.loadPixels();
    
    pixelSubtraction(currentFrame, previousFrame, diffFrame, 150, 130, 100, 130);

    blend(diffFrame, 0, 0, width, height, 0, 0, width, height, ADD);
    

    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);


    previousFrame.updatePixels();
    
    }

    if(currentImage == 4 || currentImage == 9) {

if (mov[5].isPlaying()) {
    mov[5].stop();
}     // Check if mov[5] has finished and mov[6] hasn't started yet
    if (!mov[6].isPlaying()) {
        mov[6].play();      // Play mov[6] if it's not already playing
        //println("Started movie 6 after movie 5 stopped");
    }


    
    currentFrame.copy(mov[6], 0, 0, mov[6].width, mov[6].height, 0, 0, width, height);

    currentFrame.loadPixels();
    
    pixelSubtraction(currentFrame, previousFrame, diffFrame, 150, 130, 100, 130);

    blend(diffFrame, 0, 0, width, height, 0, 0, width, height, ADD);
    

    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);


    previousFrame.updatePixels();
    
    }
    
    
          //if (counter == 12 && previousBell != 2) {
          //  playGroan_1();  // Call the function to play the bell
          //  previousBell = groan_1;


    // Transition to state 3 when the current image reaches 10
    if (currentImage == 10 ) {
        //if(previousBell != 2) {
        //    playGroan_1();  // Call the function to play the bell
        //    previousBell = groan_1;
        //}
    for (int i = ps.particles.size() - 1; i >= 0; i--) {  // Iterate backward through the list
    Particles p = ps.particles.get(i);  // Get the particle at index i
    if (p instanceof PhotoParticles && !(p instanceof Particles)) {  // Check if it's a regular particle
        ps.particles.remove(i);  // Remove it from the list
    }
     }  // Clear photo particles before moving to state 3
        currentState = 3;
        //println("Transitioning to State 3");

    }

}




if (currentState == 3) {
    //println("Confirmed: Now in State 3");
   //photoBackground();
    // Play the correct movie based on the unselectedMovie
    if (previousState4 != state4a && unselectedMovie == 1) {
        goToSB4a();
        previousState4 = state4a;
        //println("Playing movie 1");
    } else if (previousState4 != state4b && unselectedMovie == 2) {
        goToSB4b();
        previousState4 = state4b;
        //println("Playing movie 2");
    }
    


}

    if (state4Triggered && currentState == 3) {
        println("Handling transition to State 4 in draw()");
        
        // Stop the current movie
        mov[unselectedMovie].stop();

        // Transition to state 4
        currentState = 4;
        state4Triggered = false;  // Reset the flag

        endThePiece();  // Handle end logic
        println("State 4: Playing Movie " + currentMovie);
    }

    if (currentState == 4) {
        //println("Confirmed: Now in State 4");
        // Handle the crossfade effect or other logic here
    }



if (currentState == 4 ) {
    //println("sb6: " + sb6);

    //background(0);
    
    float newSpeed = map(sb6, 0, 1, 0., 1.);
    mov[currentMovie].speed(newSpeed);
    
    if(sb6 < 0.9) {
    // Correct the mappings: Fade out as sb6 decreases, fade in as it approaches 0
    //alphaIncrease = map(sb6, 0, 1, 255, 0);  // Fade in
    alphaIncrease = map(sb6, 0, 1, 130, 0); //fade in
    alphaDecrease = map(sb6, 0, 1, 0, 130);  // Fade out
    }
    

    
    // Copy current frames from both movies
    currentFrame.copy(mov[currentMovie], 0, 0, mov[currentMovie].width, mov[currentMovie].height, 0, 0, width, height);
    currentFrame2.copy(mov[7], 0, 0, mov[7].width, mov[7].height, 0, 0, width, height);

    currentFrame.loadPixels();
    currentFrame2.loadPixels();

    // Perform pixel subtraction on both frames with corrected alpha values
    pixelSubtraction(currentFrame, previousFrame, diffFrame, 130, 30, 130, 255);
    pixelSubtraction(currentFrame2, previousFrame2, diffFrame2, 50, 130, 100, alphaIncrease);

    // Render the first difference frame (fading out)
    //tint(255, alphaDecrease); 

    
    image(diffFrame, 0, 0, width, height);
    
    //noTint();
    

     //image(diffFrame2, 0, 0, width, height);
    // Render the second difference frame with additive blending (fading in)
    //blend(diffFrame2, 0, 0, width, height, 0, 0, width, height, ADD);
      blend(diffFrame2, 0, 0, width, height, 0, 0, width, height, ADD);
    //noTint();

    // Update previous frames for the next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame2.copy(currentFrame2, 0, 0, width, height, 0, 0, width, height);

    previousFrame.updatePixels();
    previousFrame2.updatePixels();
    
    if(newSpeed == 0.) {
      if(mov[currentMovie].isPlaying()){
      mov[currentMovie].stop();

      }
      if(mov[7].isPlaying()) {
        mov[7].stop();
      }
       //photoBackground();
    }
}



  ////image processing functions
  if (currentState == 1 && selectedMovie == 1 || selectedMovie == 2 ) {
    //shouldClearBackground = true;
    //image(mov[currentMovie], 0, 0, width, height);  // Display the first movie
    
    if(previousSnippet != 0) {
    recSnippets();
    previousSnippet = snippetRec;
    }
    
    //// Now apply the pixel subtraction and render the diffFrame
    currentFrame.copy(mov[selectedMovie], 0, 0, mov[selectedMovie].width, mov[selectedMovie].height, 0, 0, width, height);
    currentFrame2.copy(mov[8], 0, 0, mov[8].width, mov[8].height, 0, 0, width, height);

    currentFrame.loadPixels();
    currentFrame2.loadPixels();


    //// Perform pixel subtraction to detect motion differences
    pixelSubtraction(currentFrame, previousFrame, diffFrame, 130, 30, 130, 130);
    pixelSubtraction(currentFrame2, previousFrame2, diffFrame2, 50, 130, 100, alphaIncrease );
    

    
    alphaTarget = map(bowSpeed, 1, 3, 0, 255);
    alphaTarget = constrain(alphaTarget, 0, 255);
    
    alphaIncrease += (alphaTarget - alphaIncrease) * easingFactor;  // Easing formula
    alphaIncrease = constrain(alphaIncrease, 0, 255);

    //println("alphaIncrease: " + alphaIncrease);
    //// Render the difference frame on top of everything
    image(diffFrame, 0, 0, width, height);

    //// Blend the second movie on top of the first
    //if (bowSpeed >= 2.) {
    blend(diffFrame2, 0, 0, width, height, 0, 0, width, height, ADD);

    //// Update previous frame for the next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame2.copy(currentFrame2, 0, 0, width, height, 0, 0, width, height);


    previousFrame.updatePixels();
    previousFrame2.updatePixels();
  }
  
  
  if (currentState == 3 && selectedMovie == 1 || selectedMovie == 2) {
    //shouldClearBackground = true;
    
    // if(previousSnippet != 1) {
    //playSnippets();
    //previousSnippet = snippetPlay;
    //}
    
    int colorAdjuster = int(map(pitch, 1, 4, 80, 230));
    colorAdjuster = constrain(colorAdjuster, 80, 230);
    
    //// Now apply the pixel subtraction and render the diffFrame
    currentFrame.copy(mov[selectedMovie], 0, 0, mov[selectedMovie].width, mov[selectedMovie].height, 0, 0, width, height);
    currentFrame2.copy(mov[0], 0, 0, mov[0].width, mov[0].height, 0, 0, width, height);

    currentFrame.loadPixels();
    currentFrame2.loadPixels();


    //// Perform pixel subtraction to detect motion differences
    pixelSubtraction(currentFrame, previousFrame, diffFrame, colorAdjuster, 30, 130, 130);
    pixelSubtraction(currentFrame2, previousFrame2, diffFrame2, 70, colorAdjuster, 100, alphaIncrease );
    
    //alphaIncrease = map(bowSpeed, 1., 3., 0, 140);
    //alphaIncrease = constrain(alphaIncrease, 0, 140); 
    
    alphaTarget = map(bowSpeed, 1, 3, 0, 255);
    alphaTarget = constrain(alphaTarget, 0, 255);
    
    alphaIncrease += (alphaTarget - alphaIncrease) * easingFactor;  // Easing formula
    alphaIncrease = constrain(alphaIncrease, 0, 255);


    image(diffFrame, 0, 0, width, height);


    blend(diffFrame2, 0, 0, width, height, 0, 0, width, height, ADD);


    //// Update previous frame for the next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame2.copy(currentFrame2, 0, 0, width, height, 0, 0, width, height);


    previousFrame.updatePixels();
    previousFrame2.updatePixels();
    
    
    //            if (!hasState3Started) {
    //        startTime = millis();  // Set start time once when entering State 2
    //        counter = 0;           // Reset the counter
    //        hasState3Started = true;  // Mark that State 2 has started
    //    }

    //    // Update and display the counter based on elapsed time
    //    counter = (millis() - startTime) / 1000;
    //    println("Counter: " + counter + " sec");
    
    //     if(counter == 45 && previousSnippet != 1) {
    //playSnippets();
    //previousSnippet = snippetPlay;
    //}
  }


  //// Only process pixel subtraction and diffFrame when you're in a movie-playing state (0, 1, 3, 4)
  if (currentState == 0 ) {
    currentFrame.copy(mov[currentMovie], 0, 0, mov[currentMovie].width, mov[currentMovie].height, 0, 0, width, height);
    currentFrame.loadPixels();

    // Process the current frame to detect differences (outline)
    pixelSubtraction(currentFrame, previousFrame, diffFrame, 130, 30, 130, 130 );

    // Display the processed frame (video difference outline)
    image(diffFrame, 0, 0, width, height);

    // Save current frame as previous frame for next iteration
    previousFrame.copy(currentFrame, 0, 0, width, height, 0, 0, width, height);
    previousFrame.updatePixels();
  }

  if (currentState == 0   && transition1 == 0.85) {
    //photoBackground();
    ps.addParticle();  // Add regular particles
    
    // Apply forces to each regular particle
    for (Particles p : ps.particles) {
      if (p instanceof Particles && !(p instanceof PhotoParticles)) {
        p.applyForce(gravity);  // Apply gravity only to regular particles
        p.applyForce(wind);     // Apply wind to all regular particles
      }
    }

    ps.run();  // Update and display all regular particles
  }
  // Handle regular particles in states 1 and 3
  if (currentState == 1 || currentState == 3) {
    
    ps.addParticle();  // Add regular particles
    
    // Apply forces to each regular particle
    for (Particles p : ps.particles) {
      if (p instanceof Particles && !(p instanceof PhotoParticles)) {
        p.applyForce(gravity);  // Apply gravity only to regular particles
        p.applyForce(wind);     // Apply wind to all regular particles
        p.adjustSpeed(speedMultiplier);
      }
    }

    ps.run();  // Update and display all regular particles
  }
}
  
