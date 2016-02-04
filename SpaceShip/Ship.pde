class Ship extends Master
{
  Ship(int entry)
  {
    entryPoint = entry;

    switch (entryPoint)
    {
     case 1:
       position = new PVector(-width * 0.1f, height * 0.15f);
       movement = new PVector(speed, 0);
       break;
     case 2:
       position = new PVector(-width * 0.1f, height * 0.85f);
       movement = new PVector(speed, 0);
       break;
     case 3:
       position = new PVector(width * 1.1f, height * 0.15f);
       movement = new PVector(-speed, 0);
       break;
     case 4:
       position = new PVector(width * 1.1f, height * 0.85f);
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
     
     if (laserTimer > laserEntry)
     {
       ShipLaser laser = new ShipLaser(entryPoint); 
       laser.position = position.copy();
       //laserFire = true;
       //if (laserTimer > laserEntry * 2)
         laserTimer = 0;
     }
     laserTimer++;
  }
}