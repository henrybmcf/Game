void setup()
{
  size(600, 600);
  
  cols = 3; //<>//
  rows = 3; //<>//
  
  for(int c = 0; c < cols; c++)
  {
    for(int r = 0; r < rows; r++)
    {
      //println(noAsteroid.
//      println(noAsteroids[1][0]);
      noAsteroids[c][r] = 5;//(c + 1) * 5; //<>//
    }
  }
  
  level = 1;
  smallAstRad = 50;
  medAstRad = 100;
  largeAstRad = 150;
  
  setupAsteroidObject();
}
boolean[] keys = new boolean[512];
ArrayList<AsteroidObject> asteroids = new ArrayList<AsteroidObject>();
int cols, rows;
int[][] noAsteroids = new int[cols][rows];

int level;
float smallAstRad;
float medAstRad;
float largeAstRad;

void setupAsteroidObject()
{
  asteroids.clear();

  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);

  switch (level)
  {
    case 1:
      for (int i = 0; i < noAsteroids[0][0]; i++)
      {
        AsteroidObject asteroid = new Asteroid(smallAstRad, random(width), random(200), 1);
        asteroids.add(asteroid);
        asteroid = new Asteroid(medAstRad, random(width), random(height, height - 200), 2);
        asteroids.add(asteroid);
        asteroid = new Asteroid(largeAstRad, random(200), random(height), 3);
        asteroids.add(asteroid);
      }
      break;
  }
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
  
  for(int i = 0; i < asteroids.size(); i++)
  {
    AsteroidObject aObj = asteroids.get(i);
    aObj.update();
    aObj.render();
  }
}