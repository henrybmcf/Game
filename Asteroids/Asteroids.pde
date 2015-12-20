import ddf.minim.*;
Minim minim;

void setup()
{
  minim = new Minim(this);
  size(700, 600);
  smooth(8);
  
  for(int i = 0; i < 5; i++)
    noAsteroids[i] = i + 5;
  
  level = 1;
  smallAstRad = 30;
  medAstRad = 50;
  largeAstRad = 80;
  
  setupAsteroidObject();
}

boolean[] keys = new boolean[512];
ArrayList<AsteroidObject> asteroids = new ArrayList<AsteroidObject>();

int[] noAsteroids = new int[5];

int level;
float smallAstRad;
float medAstRad;
float largeAstRad;

PImage asteroid;

void setupAsteroidObject()
{
  asteroids.clear();

  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);

  println(noAsteroids[0]);
  switch (level)
  {
  case 1:
    for (int i = 0; i < noAsteroids[0]; i++)
    {
      //AsteroidObject asteroid = new Asteroid(smallAstRad, random(width), random(200), 3);
      //asteroids.add(asteroid);
      //asteroid = new Asteroid(medAstRad, random(width), random(height, height - 200), 2);
      //asteroids.add(asteroid);
      AsteroidObject asteroid = new Asteroid(largeAstRad, random(200), random(height), 1);
      asteroids.add(asteroid);
    }
    break;
  }
  //AsteroidObject asteroid = new Asteroid(medAstRad, random(width), random(200), 3);
  //asteroids.add(asteroid); 
  //asteroid = new Asteroid(largeAstRad, random(200), random(height), 3);
  //asteroids.add(asteroid);
  
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

void shipDeath()
{
  
}

void resetShip()
{
  asteroids.set(0, new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f));
}