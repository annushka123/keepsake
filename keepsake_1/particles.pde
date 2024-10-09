class Particles {
  PVector position;     // Current position
  PVector velocity;     // Current velocity
  PVector acceleration; // Current acceleration


  // Constructor
  Particles(PVector pos) {
    position = pos.copy();  // Start from a random position
    velocity = PVector.random2D();  // Random velocity to start
    acceleration = new PVector(0, 0);  // No acceleration to start
  }

  // Apply a force to the particle (for steering toward the target)
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // Move the particle toward the target
  void update() {

    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);  // Reset acceleration
  }

  // Display the particle as a small ellipse
  void display() {
    stroke(255);  // White stroke
    fill(255);    // White fill
    ellipse(position.x, position.y, 5, 5);  // Draw the particle as an ellipse
  }

  // Run the particle (update its state and display it)
  void run() {
    update();  // Move towards the target
    display(); // Show the particle
  }
}
