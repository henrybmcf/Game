void setup()
{
  //size(700, 600);
  fullScreen();

  aliens = new ArrayList<AlienObjects>();
  alienLasers = new ArrayList<AlienLaser>();
  
  AlienObjects alienship = new AlienSpaceShip(int(random(1, 5)));
  aliens.add(alienship);
  
  enterAlien = false;
  alienEntryTime = 180;
  alienTimer = 0;
}

ArrayList<AlienObjects> aliens;
ArrayList<AlienLaser> alienLasers;

boolean enterAlien;
int alienEntryTime;
int alienTimer;

void draw()
{ 
  background(0);
  stroke(255);

  if (alienTimer > alienEntryTime)
  {
    alienTimer = 0;
    // Set entry boolean to be true to let the alien ship know when to enter
    enterAlien = true;
  }
  alienTimer++;
  
  if (enterAlien && aliens.size() > 0)
  {
    aliens.get(0).render();
    aliens.get(0).update();
  }

  for (int i = 0; i < alienLasers.size(); i++)
  {
     alienLasers.get(i).render();
     alienLasers.get(i).update();
  }
}