

class ParticleSystem {
  ArrayList<Particles> particles;  // Store the particles in an ArrayList
  PVector origin;

  // Constructor
  ParticleSystem(PVector location) {
    origin = location.get();
    particles = new ArrayList<Particles>();
  }

  // Add a new particle to the system
  void addParticle() {
    particles.add(new Particles(origin));
  }
  
  // Add a new photo particle to the system (from random locations)
  //void addPhotoParticle(PImage img) {
  //  PVector randomPos = new PVector(random(width), random(height));  // Random position
  //  particles.add(new PhotoParticles(randomPos, img));  // Create PhotoParticle with random position
  //}

  // Run all particles (update and display them)
  void run() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particles p = particles.get(i);
      p.run();  // Update and display each particle
    }
  }
}
