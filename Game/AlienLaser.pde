class AlienLaser extends AlienObjects
{  
  AlienLaser(int pointID)
  {
    // Set random laser speed for y direction
    alienSpeed = random(3, 6);
    
    // Set shooting direction (up or down), dependent on side of entry
    // Set random shooting x direction
    if (pointID == 1 || pointID == 3)
       alienMovement = new PVector(random(-3, 3), alienSpeed);
    else
       alienMovement = new PVector(random(-3, 3), -alienSpeed);
  }
  
  void render()
  {
    pushMatrix();
    translate(alienPosition.x, alienPosition.y);
    ellipse(0, 0, 2, 2);
    popMatrix();    
  }
  
  void update()
  {
    alienPosition.add(alienMovement);
    
    // If alien laser moves off screen, remove from the array
    if (alienPosition.x < 0 || alienPosition.y < 0 || alienPosition.x > width || alienPosition.y > height)
      alienLasers.remove(this);
    
    // Check to see if any alien lasers hit any asteroids
    // Don't destroy the asteroids, just remove the lasers
    for (int i = 1; i < asteroids.size(); i++)
    {
     if (alienPosition.x > asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f &&
         alienPosition.x < asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f &&
         alienPosition.y > asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f &&
         alienPosition.y < asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f)
       {
         alienLasers.remove(this);
       }
    }
    
    
  }
}