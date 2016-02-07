class Ship extends AsteroidObject
{
  float moveAngle;
  int move;
  int left;
  int right;
  int fire;
  // Boolean to determine if ship thrust is on or not
  boolean thrust;
  int thrustFlicker;
  boolean resistance;
  int turnTimer;
  boolean turned;

  int laserTimer;
  int laserTimeLimit;
  int explosionTimer;
  int explosionRadius;
  float explosionAngle;
  PVector nukeDetection;
  float nukeAngle;
  float forcefieldRadius;
  PVector forcefieldPosition;

  Ship(int move, int left, int right, int fire, float startX, float startY)
  {
    super(startX, startY, 0);
    moveAngle = 0;
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
    resistance = false;
    thrust = true;
    thrustFlicker = 2;
    turnTimer = 0;
    turned = false;

    laserTimer = 0;
    // Divide 60 by number of bullets to shoot per second
    laserTimeLimit = 60 / 3;    
    explosionTimer = 2;
    explosionRadius = 0;
    explosionAngle = 0.0f;
    // Vector to detect if any asteroids are hitting any points on the nuclear blast circle
    nukeDetection = new PVector(0, 0);
    nukeAngle = 0;
    // Size of the forcefield
    forcefieldRadius = 70;
    // Vector to detect if any asteroids are hitting any points on the forcefield circle
    forcefieldPosition = new PVector(0, 0);
  }

  // Draw the ship in the correct position and at the correct angle
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);

    // Draw forcefield if activated
    if (activated[3])
    {
      fill(0);
      stroke(yellow);
      ellipse(0, 0, forcefieldRadius * 2.0f, forcefieldRadius * 2.0f);
    }

    rotate(facingAngle);
    stroke(aqua);
    line(0, -shipHeight, -shipWidth, shipHeight);
    line(0, -shipHeight, shipWidth, shipHeight);
    line(-shipWidth * 0.75f, shipHeight * 0.7f, shipWidth * 0.75f, shipHeight * 0.7f);

    // Draw thrust flame is ship is moving
    if (thrust)
    {
      if (thrustFlicker > 2)
      {
        // Alternate colour of thruster flame between red and yellow
        thrustColour =! thrustColour;
        if (thrustColour)
          stroke(red);
        else
          stroke(yellow);
        line(0, shipHeight * 1.3f, -shipWidth * 0.4f, shipHeight * 0.75f);
        line(0, shipHeight * 1.3f, shipWidth * 0.4f, shipHeight * 0.75f);
        thrustFlicker = 0;
      }
    }
    popMatrix();
    thrustFlicker++;
  }

  void update()
  { 
    moveShip.x = sin(moveAngle);
    moveShip.y = -cos(moveAngle);
    moveShip.mult(speed);

    // Move or rotate ship depending on key pressed
    if (keys[move])
    {
      // On pressing thrust key (move), set moveAngle to be facingAngle, so that ship moves in direction it is facing. Use of turned variable to ensure it only does this once each time it is pressed
      if (turned == false)
      {
        moveAngle = facingAngle;
        turned = true;
      }     
      position.add(moveShip);

      // Simulate acceleration
      if (speed < 4.0f)
        speed = speed * 1.15f;
      else
        speed = 4.0f;

      resistance = true;

      // Set speed of turning dependent on angle of turn. Time turn to prevent instantaneous turning, simulating original game
      if (turnTimer > 2)
      {
        if (moveAngle < facingAngle)
          moveAngle += map(facingAngle - moveAngle, 0, HALF_PI, 0.05, 0.12);
        else if (moveAngle > facingAngle)
          moveAngle -= map(moveAngle - facingAngle, 0, HALF_PI, 0.05, 0.12);
        turnTimer = 0;
      }
      turnTimer++;
    }

    if (keys[move] != true)
      turned = false;

    if (keys[left])
      facingAngle -= 0.08f;     
    if (keys[right])
      facingAngle += 0.08f;

    if (keys[move] || keys[left] || keys[right])
    {
      thrust = true;
      playSound(4);
    } else
    {
      thrust = false;
    }

    // Simulate resistance like in original game
    // Once not moving (move key not pressed), reduce speed until stop
    if (resistance && keys[move] == false)
    {
      speed = speed * 0.99f;
      position.add(moveShip);
      if (speed < 0.02)
        resistance = false;
    }

    // Rapid fire powerup
    if (activated[5])
      laserTimeLimit = 60 / 12;
    else
      laserTimeLimit = 60 / 3;

    // Shoot laser if fire key is pressed and over time limit (ship can only shoot certain amount of lasers per second)
    if (keys[fire] && laserTimer > laserTimeLimit)
    {
      playSound(5);

      Laser laser = new Laser();
      laser.position = position.copy();
      laser.facingAngle = facingAngle;
      lasers.add(laser);

      // Double Shooter
      if (activated[0])
      {
        Laser doubleLaser = new Laser();
        doubleLaser.position = position.copy();
        doubleLaser.facingAngle = facingAngle + PI;
        lasers.add(doubleLaser);
      }      
      // Quad Shooter
      if (activated[1])
      {
        for (int i = 1; i < 4; i ++)
        {
          Laser quadLaser = new Laser();
          quadLaser.position = position.copy();
          quadLaser.facingAngle = facingAngle + (i * HALF_PI);
          lasers.add(quadLaser);
        }
      }
      laserTimer = 0;
    }
    laserTimer++;

    // If ship goes off screen, loop around to other side of screen
    if (position.x < 0)
      position.x = width;
    if (position.x > width)
      position.x = 0;
    if (position.y < 0)
      position.y = height;
    if (position.y > height)
      position.y = 0;

    // If ship hits (collects) a power up, hide powerup (set onScreen to be false) and set powerup entry timer to zero (i.e. start timing for next powerup to enter)
    if (position.x > power.pos.x - 30 && position.x < power.pos.x + 30 && position.y > power.pos.y - 30 && position.y < power.pos.y + 30)
    {
      power = new PowerUp(random(width), -20);
      // If powerup isn't extra life
      if (powerup != 6)
      {
        collected[powerup] = true;
      } else
      {
        if (lives < 10)
          lives++;
      }
      onScreen[powerup] = false;
      pUpEntryTimer = 0;
    }

    // Detect collision with alien ship
    if (aliens.get(0).alienPosition.x + aliens.get(0).alienShipWidth > position.x - shipWidth &&
      aliens.get(0).alienPosition.x - aliens.get(0).alienShipWidth < position.x + shipWidth &&
      aliens.get(0).alienPosition.y + aliens.get(0).alienShipHeight > position.y - shipHeight &&
      aliens.get(0).alienPosition.y - aliens.get(0).alienShipWidth < position.y + shipHeight)
    {
      // Kill alien ship
      alienShipDead = true;    
      // Kill player ship
      callShipDeath(); 
      
      if (reset)
      {
        score += 100;
        reset = false;
      }
    }
    
    // Check to see if any alien lasers hit the player
    for (int i = 0; i < alienLasers.size(); i++)
    {
        if (alienLasers.get(i).alienPosition.x > position.x - shipWidth &&
            alienLasers.get(i).alienPosition.x < position.x + shipWidth &&
            alienLasers.get(i).alienPosition.y > position.y - shipHeight &&
            alienLasers.get(i).alienPosition.y < position.y + shipHeight)
        {
          callShipDeath();
        }
    }

    for (int i = 1; i < asteroids.size(); i++)
    {
      // For each asteroid check to see if ship is touching
      if (asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f > position.x - shipWidth && 
        asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f < position.x + shipWidth &&
        asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f > position.y - shipHeight &&
        asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f < position.y + shipHeight)
      {
        callShipDeath();

        if (reset)
        {
          splitAsteroid(i);
          reset = false;
        }
      }
    }

    if (activated[2])
    {
      // Time exlposion graphics of ship explosion
      if (nukeTimer == 2)
      {
        if (nukeRadius < 200)
        {
          nukeRadius += 4;
          nukeAngle += 0.08f;
          nukeExplosion(nukeAngle);
          nukeRadius -= 3;
          nukeAngle -= 0.05f;
          nukeExplosion(nukeAngle);
          nukeTimer = 0;
        } else
        {
          activated[2] = false;
          nukeRadius = 30;
          nukeTimer = 0;
        }
      }
      nukeTimer++;

      // Check to see if any asteroids are withing nuclear blast radius by looping through all angles (in a circle)
      // and calculating x & y coordinates of each of those points check to see if they are hitting asteroids, if they are, remove them from the game
      for (float alpha = 0; alpha < TWO_PI; alpha += 0.1f)
      {
        nukeDetection.x = nukeRadius * cos(alpha) + nukePos.x;
        nukeDetection.y = nukeRadius * sin(alpha) + nukePos.y;

        // For each asteroid check to see if forcefield is touching asteroids
        for (int i = 1; i < asteroids.size(); i++)
        {
          if (nukeDetection.x > asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f && 
            nukeDetection.x < asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f &&
            nukeDetection.y > asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f &&
            nukeDetection.y < asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f)
          {
            playSound(6);
            asteroids.remove(i);
          }
        }

        if (nukeDetection.x > aliens.get(0).alienPosition.x - aliens.get(0).alienShipWidth &&
          nukeDetection.x < aliens.get(0).alienPosition.x + aliens.get(0).alienShipWidth &&
          nukeDetection.y > aliens.get(0).alienPosition.y - aliens.get(0).alienShipHeight &&
          nukeDetection.y < aliens.get(0).alienPosition.y + aliens.get(0).alienShipHeight)
        {
          aliens.set(0, new AlienSpaceShip(int(random(1, 5))));
          enterAlien = false;
          alienTimer = 0;
          score += 100;
        }
      }
    }

    // If forcefield powerup is active
    // Loop through all angles (in a circle), calculate x & y coordinates of each of those points check to see if they are hitting asteroids
    else if (activated[3])
    {
      // Forcefield asteroid hit detection
      for (float alpha = 0; alpha < TWO_PI; alpha += 0.1f)
      {
        forcefieldPosition.x = forcefieldRadius * cos(alpha) + position.x;
        forcefieldPosition.y = forcefieldRadius * sin(alpha) + position.y;

        // For each asteroid check to see if forcefield is touching asteroids
        for (int i = 1; i < asteroids.size(); i++)
        {
          if (forcefieldPosition.x > asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f && 
            forcefieldPosition.x < asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f &&
            forcefieldPosition.y > asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f &&
            forcefieldPosition.y < asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f)
          {
            splitAsteroid(i);
          }
        }

        if (forcefieldPosition.x > aliens.get(0).alienPosition.x - aliens.get(0).alienShipWidth &&
          forcefieldPosition.x < aliens.get(0).alienPosition.x + aliens.get(0).alienShipWidth &&
          forcefieldPosition.y > aliens.get(0).alienPosition.y - aliens.get(0).alienShipHeight &&
          forcefieldPosition.y < aliens.get(0).alienPosition.y + aliens.get(0).alienShipHeight)
        {
          aliens.set(0, new AlienSpaceShip(int(random(1, 5))));
          enterAlien = false;
          alienTimer = 0;
          score += 100;
        }
        
        for (int j = 0; j < alienLasers.size(); j++)
        {
          float dist = PVector.dist(position, alienLasers.get(j).alienPosition);
          if (dist < forcefieldRadius + alienLasers.get(0).laserSize)
              alienLasers.remove(j);
        }
      }
    }
  }

  void callShipDeath()
  {
    // Stop the game
    gameStart = false;
    // Stop ship from moving
    resistance = false;

    // If the player still has lives, deduct a life
    if (lives > 0)
    { 
      // Ensures that only one life is deducted per crash
      if (livesHitCounter == 0)
        lives--;
      livesHitCounter = 1;

      // Clear all lasers from the screen so upon restart of game, they won't continue to show
      lasers.clear();

      // Graphics of ship explosion
      explosionAngle += 0.1f;
      if (shipDebrisPositions.get(0).x == 0)
      {
        for (int i = 0; i < 5; i++)
        {
          shipDebrisPositions.set(i, position.copy());
          if (i < 3)
            shipDebrisMovements.set(i, new PVector(random(moveShip.x / 2), random(moveShip.y / 2)));
          else
            shipDebrisMovements.set(i, new PVector(random(-moveShip.x / 2), random(moveShip.y / 2)));
        }
      }

      shipDeath(explosionAngle);
    }
    // If user has no more lives, give them the option to play the game again
    else if (showHighScores != true)
    {
      gameOver(false);
    }
  }
}