void setup()
{
  size(700, 600);

  aliens = new ArrayList<AlienObjects>();
  alienLasers = new ArrayList<AlienLaser>();
  
  AlienObjects alienship = new AlienSpaceShip(int(random(1, 5)));
  aliens.add(alienship);
}

ArrayList<AlienObjects> aliens;
ArrayList<AlienLaser> alienLasers;

void draw()
{ 
  background(0);
  stroke(255);
 
  aliens.get(0).update();
  aliens.get(0).render();

  for (int i = 0; i < alienLasers.size(); i++)
  {
     alienLasers.get(i).render();
     alienLasers.get(i).update();
  }
}