class Ship extends AsteroidObject
{
  int move;
  int left;
  int right;
  int fire;
  int laserTimer;
  int laserTimeLimit;
  //boolean thrust;
  int thrustFlicker;
  
  int explosionTimer;
  int explosionRadius;
  
  boolean resistance;
  
  float expTheta;

  Ship(int move, int left, int right, int fire, float startX, float startY)
  {
    super(startX, startY, 0);
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
    // Divide 60 by number of bullets to shoot per second
    laserTimeLimit = 60 / 3;
    laserTimer = 0;
    //thrust = false;
    thrustFlicker = 2;
    explosionTimer = 2;
    resistance = false;
    
    expTheta = 0.0f;
  }

  // Draw the ship in the correct position and at the correct angle
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
    if (exp)
    {
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
        shipDeath(position, explosionRadius - 15, expTheta);
      }
      explosionTimer+=1;
    }
         
    moveShip.x = sin(theta);
    moveShip.y = - cos(theta);
    moveShip.mult(speed);
   
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
      thrustSound.play();
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
       speed = speed * 0.985;
       position.add(moveShip);
       if (speed < 0.02)
       {
         resistance = false;
       }
    }

    if (keys[fire] && laserTimer > laserTimeLimit)
    {
      laserSound.play();   
      Laser laser = new Laser();
      laser.position.x = position.x;
      laser.position.y = position.y;
      laser.position.add(PVector.mult(moveShip, 6));
      laser.theta = theta;
      lasers.add(laser);
      laserTimer = 0;
    }
    laserTimer++;

    if (position.x < 0)
      position.x = width;
    if (position.x > width)
      position.x = 0;
    if (position.y < 0)
      position.y = height;
    if (position.y > height)
      position.y = 0;
      
    for (int i = 1; i < asteroids.size(); i++)
    {
      if (position.x +- shipWidth > asteroids.get(i).position.x - asteroids.get(i).radius * 0.65f &&
          position.x +- shipWidth < asteroids.get(i).position.x + asteroids.get(i).radius * 0.65f &&
          position.y +- shipHeight > asteroids.get(i).position.y - asteroids.get(i).radius * 0.5f &&
          position.y +- shipHeight < asteroids.get(i).position.y + asteroids.get(i).radius * 0.5f)
      {
         gameStart = false;
         if (explosionTimer > 1)
         {
           //shipDeath(position, explosionRadius);
           explosionRadius += 2;
           explosionTimer = 0;
         }
         explosionTimer++;
              
         if (asteroids.get(i).position.x > width * 0.4f && asteroids.get(i).position.x < width * 0.6f
            && asteroids.get(i).position.y > height * 0.4f && asteroids.get(i).position.y < height * 0.6f)
         {
           asteroids.get(i).position.x = random(width);
           asteroids.get(i).position.y = random(200);
         }
         countdown = 3;
      }
    }
  }
}