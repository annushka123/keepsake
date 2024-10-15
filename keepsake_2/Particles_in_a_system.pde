

class ParticleSystem {
  ArrayList<Particles> particles;  // Store the particles in an ArrayList
  

  // Constructor
  ParticleSystem() {
    
    particles = new ArrayList<Particles>();
  }

  // Add a new particle to the system
  void addParticle() {
    PVector randomLocation = new PVector(random(width), random(height));
    particles.add(new Particles(randomLocation));
  }
  
  // Add a new photo particle to the system (from random locations)
  void addPhotoParticle() {
    PVector randomPos = new PVector(random(width), random(height));  // Random position
    particles.add(new PhotoParticles(randomPos));  // Create PhotoParticle with random position
  }

  // Run all particles (update and display them)
  void run() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particles p = particles.get(i);
      p.run();  // Update and display each particle
      if(p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
    // Clear all particles
  void clear() {
    particles.clear();  // Remove all particles from the list
  }
}
