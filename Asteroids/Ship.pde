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
  }

  // Draw the ship in the correct position and at the correct angle
  // Draw thrust flame is ship is moving
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    stroke(0, 206, 209);
    line(0, -shipHeight, -shipWidth, shipHeight);
    line(0, -shipHeight, shipWidth, shipHeight);
    line(-shipWidth * 0.75f, shipHeight * 0.7f, shipWidth * 0.75f, shipHeight * 0.7f);
    if (thrust)
    {
      if (thrustFlicker > 2)
      {
        // Alternate colour of thruster flame between red and yellow
        thrustColour =! thrustColour;
        if (thrustColour)
          stroke(255, 0, 0);
        else
          stroke(255, 255, 0);
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
      //thrustSound.amp(0.08);
    } else
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
      if (powerUps[0])
      {
        Laser doubleLaser = new Laser();
        doubleLaser.position.x = position.x;
        doubleLaser.position.y = position.y;
        doubleLaser.position.add(PVector.mult(moveShip, 6));
        doubleLaser.theta = theta + PI;
        lasers.add(doubleLaser);
      }
      // Quad Shooter
      if (powerUps[1])
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

    // Power Up hit detection
    //if (position.x > power.pos.x - 15 && position.x < power.pos.x + 15 && position.y > power.pos.y - 15 && position.y < power.pos.y + 15)
     
    
    
    for (int i = 1; i < asteroids.size(); i++)
    {
      // For each asteroid check to see if ship is touching
      if (asteroids.get(i).position.x + asteroids.get(i).radius * 0.5f > position.x - shipWidth && 
        asteroids.get(i).position.x - asteroids.get(i).radius * 0.5f < position.x + shipWidth &&
        asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f > position.y - shipHeight &&
        asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f < position.y + shipHeight)
      {
        // If the player still has lives, deduct a life
        if (lives > 0)
        {
          // Ensure only one life is dedcuted per crash
          if (livesHitCounter == 0)
            lives--;     
          livesHitCounter = 1;
          
          // Clear all lasers from the screen so upon restart of game, they won't continue to show
          lasers.clear();
          // Stop the game
          gameStart = false;
          // Stop ship from moving
          resistance = false;
          // Time exlposion grpahics of ship
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
          gameStart = false;
          fill(255);
          textSize(40);
          text("GAME OVER", width * 0.5f, height * 0.3f);
          text("Play Again?", width * 0.5f, height * 0.5f);
          text("Yes", width * 0.3f, height * 0.8f);
          text("No", width * 0.7f, height * 0.8f);
          
          // If they select to play again, setup asteroids and reset level
          // Otherwise, exit the game
          if (mousePressed)
          {
            if (mouseY > height * 0.7f && mouseY < height * 0.9f)
            {
              if (mouseX > width * 0.15f && mouseX < width * 0.45f)
              {
                level = 1;
                setupAsteroidObject();
              }
              else if (mouseX > width * 0.55f && mouseX < width * 0.85f)
              {
                exit();
              }
            }
          }
        }
      }
    }
  }
}