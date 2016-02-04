class AlienSpaceShip extends AlienObjects
{
  int fire;
  int laserTimer;
  int laserTimeLimit;
  
  AlienSpaceShip(int entrypoint)
  {
    entryPoint = entrypoint;
    
    laserTimer = 0;
    laserTimeLimit = 80;
    
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
    line(-sw * 0.3f, -sh, sw * 0.3f, -sh);
    line(-sw * 0.3f, -sh, -sw * 0.45f, -sh * 0.35f);
    line(sw * 0.3f, -sh, sw * 0.45f, -sh * 0.35f);
    line(-sw * 0.45f, -sh * 0.35f, sw * 0.45f, -sh * 0.35f);  
    // Middle Body
    line(-sw * 0.45f, -sh * 0.35f, -sw, sh * 0.3f);
    line(sw * 0.45f, -sh * 0.35f, sw, sh * 0.3f);
    line(-sw, sh * 0.3f, sw, sh * 0.3f);
    // Bottom Body
    line(-sw, sh * 0.3f, -sw * 0.45f, sh);
    line(sw, sh * 0.3f, sw * 0.45f, sh);
    line(-sw * 0.45f, sh, sw * 0.45f, sh);
    popMatrix();
  }

  void update()
  { 
    position.add(movement);

    if (laserTimer > laserTimeLimit)
    {
      //println("Shooting");
      AlienLaser laser = new AlienLaser(entryPoint);
      laser.position = position.copy(); 
      laser.entryPoint = entryPoint;
      alienLasers.add(laser);
  
      laserTimer = 0;
    }
    laserTimer++;

    if (position.x < 0)
      position.x = width;
    if (position.x > width)
      position.x = 0;
  }
}