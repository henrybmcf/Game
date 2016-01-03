class Ship extends AsteroidObject
{
  int move;
  int left;
  int right;
  int fire;
  int laserTimer;
  int laserTimeLimit;
  int thrustFlicker;  
  int explosionTimer;
  int explosionRadius;
  float expTheta;
  boolean resistance;
  float angle;


  float forcefieldRadius;
  PVector forcefieldPosition;

  Ship(int move, int left, int right, int fire, float startX, float startY)
  {
    super(startX, startY, 0);
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
    // Divide 60 by number of bullets to shoot per second
    laserTimeLimit = 60 / 2;
    laserTimer = 0;
    thrustFlicker = 2;
    explosionTimer = 2;
    expTheta = 0.0f;
    resistance = false;
    angle = 0;

    forcefieldRadius = 70;
    forcefieldPosition = new PVector(0, 0);
  }

  // Draw the ship in the correct position and at the correct angle
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    
    if (activated[3])
    {
      fill(0);
      stroke(yellow);
      ellipse(0, 0, forcefieldRadius * 2.0f, forcefieldRadius * 2.0f);
    }

    rotate(theta);
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
    if (activated[2])
    {
      // Time exlposion graphics of ship explosion
      if (nukeTimer == 2)
      {
        if (nukeRadius < 200)
        {
          nukeRadius += 4;
          angle += 0.08f;
          nukeExplosion(position, angle);
          nukeRadius -= 3;
          angle -= 0.05f;
          nukeExplosion(position, angle);
          nukeTimer = 0;
        } else
        {
          activated[2] = false;
          nukeRadius = 30;
          nukeTimer = 0;
        }
      }
      nukeTimer++;

      // Check to see if any asteroids are withing nuke blast radius, if they are, remove them from the game
      for (int i = 1; i < asteroids.size(); i++)
      {
        if (asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f > position.x - nukeRadius && 
          asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f < position.x + nukeRadius &&
          asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f > position.y - nukeRadius &&
          asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f < position.y + nukeRadius)
        {
          //nukeSound.play();
          asteroids.remove(i);
        }
      }
    }
    
    // If forcefield powerup is active
    // Loop through all angles (in a circle), calculate x & y coordinates of each of those points check to see if they are hitting asteroids
    if (activated[3])
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
      }
    }
    
    moveShip.x = sin(theta);
    moveShip.y = - cos(theta);
    moveShip.mult(speed);

    // Move or rotate ship depending on key pressed
    if (keys[move])
    {
      position.add(moveShip);
      speed = 2.5f;
      resistance = true;
    }
    if (keys[left])
      theta -= 0.05f;
    if (keys[right])
      theta += 0.05f;
    if (keys[move] || keys[left] || keys[right])
    {
      thrust = true;
      //thrustSound.play();
      thrustSound.amp(0.08);
    }
    else
    {
      thrust = false;
    }

    // Simulate resistance like in original game
    // Once not moving (move key not pressed), reduce speed until stop
    if (resistance && keys[move] == false)
    {
      speed = speed * 0.99;
      position.add(moveShip);
      if (speed < 0.02)
        resistance = false;
    }

    // Shoot lasers if fire key is pressed and over time limit (ship can only shoot certain amount of lasers per second
    if (keys[fire] && laserTimer > laserTimeLimit)
    {
      //laserSound.play();
      Laser laser = new Laser();
      laser.position.x = position.x;
      laser.position.y = position.y;
      laser.position.add(PVector.mult(moveShip, 6));
      laser.theta = theta;
      lasers.add(laser);
      // Double Shooter
      if (activated[0])
      {
        Laser doubleLaser = new Laser();
        doubleLaser.position.x = position.x;
        doubleLaser.position.y = position.y;
        doubleLaser.position.add(PVector.mult(moveShip, 6));
        doubleLaser.theta = theta + PI;
        lasers.add(doubleLaser);
      }
      // Quad Shooter
      if (activated[1])
      {
        for (int i = 1; i < 4; i ++)
        {
          Laser quadLaser = new Laser();
          quadLaser.position.x = position.x;
          quadLaser.position.y = position.y;
          quadLaser.position.add(PVector.mult(moveShip, 6));
          quadLaser.theta = theta + (i * HALF_PI);
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
      if (powerup != 4)
      {
        collected[powerup] = true;
      } else
      {
        if (lives < 10)
          lives++;
      }
      onScreen[powerup] = false;
      entryCountTimer = 0;
    }

    for (int i = 1; i < asteroids.size(); i++)
    {
      // For each asteroid check to see if ship is touching
      if (asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f > position.x - shipWidth && 
        asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f < position.x + shipWidth &&
        asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f > position.y - shipHeight &&
        asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f < position.y + shipHeight)
      {
        // Stop the game
        gameStart = false;
        // Stop ship from moving
        resistance = false;
        
        // If the player still has lives, deduct a life
        if (lives > 0)
        { 
          // Ensure only one life is dedcuted per crash
          if (livesHitCounter == 0)
            lives--;
          livesHitCounter = 1;

          // Clear all lasers from the screen so upon restart of game, they won't continue to show
          lasers.clear();
          
          // Time exlposion graphics of ship explosion
          if (explosionTimer > 1)
          {
            shipDeath(position, explosionRadius, expTheta);
            if (explosionRadius < 40)
              explosionRadius += 2;
            else
              explosionRadius = 0;
            explosionTimer = 0;
            if (random(1) > 0.5f)
              expTheta += 2.5f;
            else
              expTheta -= 3.5f;
            shipDeath(position, explosionRadius - 20, expTheta);
          }
          explosionTimer++;
        }
        // If user has no more lives, give them the option to play the game again
        else
        {
          playAgain(false);
        }

        if (reset)
        {
          splitAsteroid(i);
          reset = false;
        }
      }
    }
  }
}