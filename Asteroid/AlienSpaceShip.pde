class AlienSpaceShip extends AlienObjects
{
  int fire;
  int laserTimer;
  int laserTimeLimit;
  
  AlienSpaceShip(int entrypoint)
  {
    entryPoint = entrypoint;
    
    laserTimer = 0;
    laserTimeLimit = 90;
    
    float topEntry = random(height * 0.1f, height * 0.3f);
    float bottomEntry = random(height * 0.7f, height * 0.9f);
    
    switch (entrypoint)
    {
     case 1:
       position = new PVector(-width * 0.1f, topEntry);
       movement = new PVector(speed, 0);
       break;
     case 2:
       position = new PVector(-width * 0.1f, bottomEntry);
       movement = new PVector(speed, 0);
       break;
     case 3:
       position = new PVector(width * 1.1f, topEntry);
       movement = new PVector(-speed, 0);
       break;
     case 4:
       position = new PVector(width * 1.1f, bottomEntry);
       movement = new PVector(-speed, 0);
       break;
    }
  }

  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    // Top body
    line(-alienShipWidth * 0.3f, -alienShipHeight, alienShipWidth * 0.3f, -alienShipHeight);
    line(-alienShipWidth * 0.3f, -alienShipHeight, -alienShipWidth * 0.45f, -alienShipHeight * 0.35f);
    line(alienShipWidth * 0.3f, -alienShipHeight, alienShipWidth * 0.45f, -alienShipHeight * 0.35f);
    line(-alienShipWidth * 0.45f, -alienShipHeight * 0.35f, alienShipWidth * 0.45f, -alienShipHeight * 0.35f);  
    // Middle Body
    line(-alienShipWidth * 0.45f, -alienShipHeight * 0.35f, -alienShipWidth, alienShipHeight * 0.3f);
    line(alienShipWidth * 0.45f, -alienShipHeight * 0.35f, alienShipWidth, alienShipHeight * 0.3f);
    line(-alienShipWidth, alienShipHeight * 0.3f, alienShipWidth, alienShipHeight * 0.3f);
    // Bottom Body
    line(-alienShipWidth, alienShipHeight * 0.3f, -alienShipWidth * 0.45f, alienShipHeight);
    line(alienShipWidth, alienShipHeight * 0.3f, alienShipWidth * 0.45f, alienShipHeight);
    line(-alienShipWidth * 0.45f, alienShipHeight, alienShipWidth * 0.45f, alienShipHeight);
    popMatrix();
  }

  void update()
  { 
    position.add(movement);

    if (laserTimer > laserTimeLimit)
    {
      AlienLaser laser = new AlienLaser(entryPoint);
      laser.position = position.copy();
      laser.entryPoint = entryPoint;
      alienLasers.add(laser);
  
      laserTimer = 0;
    }
    laserTimer++;
    
    // If alien ship moves off screen, remove from the ship from the arraylist
    // Then create a new alien ship with a new entry point
    // Set the entry boolean to be false and reset the entry timer to begin the timer to the entry of the next ship
    if (entryPoint == 1 || entryPoint == 2)
    {
      if (position.x + alienShipWidth > width)
      {
        aliens.remove(this);
        AlienObjects alienship = new AlienSpaceShip(int(random(1, 5)));
        aliens.add(alienship);
        
        enterAlien = false;
        alienTimer = 0;
      }
    }
    else if (entryPoint == 3 || entryPoint == 4)
    {
      if (position.x - alienShipWidth < 0)
      {
        aliens.remove(this);
        AlienObjects alienship = new AlienSpaceShip(int(random(1, 5)));
        aliens.add(alienship);
        enterAlien = false;
        alienTimer = 0;
      } 
    }
    
    // Reset timer while alien ship is on screen to prevent multiple executions
    if (position.x > 0 && position.x < width)
      alienTimer = 0;
  }
}