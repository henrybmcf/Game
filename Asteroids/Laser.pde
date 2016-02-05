class Laser extends AsteroidObject
{  
  Laser()
  {
    speed = 10.0f;
  }
  
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    rotate(facingAngle);
    // Alternate colour of lasers between red and yellow
    if (colourSwap)
      stroke(red);
    else
      stroke(yellow);
    ellipse(0, 0, 2, 2);
    popMatrix();    
  }
  
  void update()
  { 
    moveShip.x = sin(facingAngle);
    moveShip.y = - cos(facingAngle);  
    moveShip.mult(speed);
    position.add(moveShip);
    
    // If laser goes out of bounds (off screen), remove from list of lasers
    if (position.x < 0 || position.y < 0 || position.x > width || position.y > height)
      lasers.remove(this);
    
    // Check to see if any lasers hit any asteroids
    for (int i = 1; i < asteroids.size(); i++)
    {
      if (position.x > asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f &&
          position.x < asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f &&
          position.y > asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f &&
          position.y < asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f)
      {
        splitAsteroid(i);
        lasers.remove(this);
      }
    }
    
    //if (position.x > aliens.get(0).position.x - alienShipWidth &&
    //    position.x < aliens.get(0).position.x + alienShipWidth &&
    //    position.y > aliens.get(0).position.y - alienShipHeight &&
    //    position.y < aliens.get(0).position.y + alienShipHeight)
    //{
    //   alienShipDead = true; 
    //}   
  }
}