class AlienSpaceShip extends AlienObjects
{
  int laserTimer;
  int laserTimeLimit;

  AlienSpaceShip(int entrypoint)
  {
    alienShipDead = false;
    entryPoint = entrypoint;

    laserTimer = 0;
    laserTimeLimit = 60;

    float topEntry = random(height * 0.1f, height * 0.3f);
    float bottomEntry = random(height * 0.7f, height * 0.9f);

    switch (entrypoint)
    {
    case 1:
      alienPosition = new PVector(-width * 0.1f, topEntry);
      alienMovement = new PVector(alienSpeed, 0);
      break;
    case 2:
      alienPosition = new PVector(-width * 0.1f, bottomEntry);
      alienMovement = new PVector(alienSpeed, 0);
      break;
    case 3:
      alienPosition = new PVector(width * 1.1f, topEntry);
      alienMovement = new PVector(-alienSpeed, 0);
      break;
    case 4:
      alienPosition = new PVector(width * 1.1f, bottomEntry);
      alienMovement = new PVector(-alienSpeed, 0);
      break;
    }
  }

  void render()
  {
    stroke(0, 180, 0);
    pushMatrix();
    translate(alienPosition.x, alienPosition.y);
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
    alienPosition.add(alienMovement);

    if (laserTimer > laserTimeLimit)
    {
      AlienLaser laser = new AlienLaser(entryPoint);
      laser.alienPosition = alienPosition.copy();
      laser.entryPoint = entryPoint;
      alienLasers.add(laser);
      laserTimer = 0;
    }
    laserTimer++;

    // If alien ship moves off screen, set the element of the arraylist to be a new alien ship with a new entry point
    // Set the entry boolean to be false and reset the entry timer to begin the timer to the entry of the next ship
    if (alienPosition.x < -width * 0.2f || alienPosition.x > width * 1.2f)
    {
      aliens.set(0, new AlienSpaceShip(int(random(1, 5))));
      enterAlien = false;
      alienTimer = 0;
    }

    // Reset timer while alien ship is on screen to prevent multiple executions
    if (alienPosition.x > 0 && alienPosition.x < width)
      alienTimer = 0;

    // Check for alien ship collision with any asteroids
    for (int i = 1; i < asteroids.size(); i++)
    {
      if (asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f > alienPosition.x - alienShipWidth && 
        asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f < alienPosition.x + alienShipWidth &&
        asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f > alienPosition.y - alienShipHeight &&
        asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f < alienPosition.y + alienShipHeight)
      {
        alienDeath();
      }
    }

    // Check to see if any player lasers hit the alien ship
    for (int i = 0; i < lasers.size(); i++)
    {
      if (lasers.get(i).position.x > alienPosition.x - alienShipWidth &&
        lasers.get(i).position.x < alienPosition.x + alienShipWidth &&
        lasers.get(i).position.y > alienPosition.y - alienShipHeight &&
        lasers.get(i).position.y < alienPosition.y + alienShipHeight)
      {
        lasers.remove(i);
        score += 100;
        alienDeath();
      }
    }
  }

  void alienDeath()
  {
    aliens.set(0, new AlienSpaceShip(int(random(1, 5))));
    enterAlien = false;
    alienTimer = 0;
    for (int j = 0; j < 6; j++)
      asteroidDebrisPosition.add(alienPosition.copy());       
    times.append(debrisTimer);
    debrisTimer++;
    debris = true;
  }
}