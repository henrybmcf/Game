void setup()
{
   size(500, 500);
   
   // Pass random entry point here?
   spaceship = new Ship(int(random(1, 5)));
   
   spaceshipTimer = 0;
   spaceshipEntry = 1200;
   
   //laser = new ShipLaser();
   
   laserTimer = 0;
   laserEntry = 180;
   
   laserFire = false;
}

int entryPoint;

Ship spaceship;

PVector position;
int spaceshipTimer;
int spaceshipEntry;

//ShipLaser laser;

//PVector laserpos;
int laserTimer;
int laserEntry;

boolean laserFire;

void draw()
{
  background(0); 
  stroke(255);
  
  ellipse(width * 0.5f, height * 0.5f, 3, 3);
  
  if (spaceshipTimer > spaceshipEntry)
  {
    spaceship = new Ship(int(random(1, 5)));
    spaceshipTimer = 0;
  }
  spaceshipTimer++;
  
  spaceship.render();
  spaceship.update();
  
  //if (laserFire)
  //{
  //  laser.render();
  //  laser.update();
  //}
}