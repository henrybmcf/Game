void setup()
{
  size(600, 600);

  //for(int i = 0; i < 9; i++)
  //{
  //  noAsteroids[i] = 3;
  //}
  
  level = 1;
  smallAstRad = 10;
  medAstRad = 20;
  largeAstRad = 30;
  
  setupAsteroidObject();
}
boolean[] keys = new boolean[512];
ArrayList<AsteroidObject> asteroids = new ArrayList<AsteroidObject>();

int[] noAsteroids = new int[9];

int level;
float smallAstRad;
float medAstRad;
float largeAstRad;

void setupAsteroidObject()
{
  asteroids.clear();

  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);

  //switch (level)
  //{
  //  case 1:
  //    for (int i = 0; i < 5; i++)
  //    {
  //      AsteroidObject asteroid = new Asteroid(smallAstRad, random(width), random(200), 1);
  //      asteroids.add(asteroid);
  //      asteroid = new Asteroid(medAstRad, random(width), random(height, height - 200), 2);
  //      asteroids.add(asteroid);
  //      asteroid = new Asteroid(largeAstRad, random(200), random(height), 3);
  //      asteroids.add(asteroid);
  //    }
  //    break;
  //}
}

void keyPressed()
{
  keys[keyCode] = true;
}

void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);
  stroke(255);
  for(int i = 0; i < asteroids.size(); i++)
  {
    AsteroidObject aObj = asteroids.get(i);
    aObj.update();
    aObj.render();
  }
}