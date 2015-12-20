import ddf.minim.*;
Minim minim;

void setup()
{
  minim = new Minim(this);
  size(700, 600);
  smooth(8);
  for (int i = 0; i < 5; i++)
    noAsteroids[i] = i + 5;
  gameStart = false;
  level = 0;
  countdown = 3;
  countdownTimer = 0;
  smallAstRad = 30;
  medAstRad = 50;
  largeAstRad = 80;
  setupAsteroidObject();
}

boolean[] keys = new boolean[512];
ArrayList<AsteroidObject> asteroids = new ArrayList<AsteroidObject>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
int[] noAsteroids = new int[5];
boolean gameStart;
int level;
int countdown;
int countdownTimer;
float smallAstRad;
float medAstRad;
float largeAstRad;
PImage asteroid;

void setupAsteroidObject()
{
  lasers.clear();
  asteroids.clear();
  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);
  
  //switch (level)
  //{
  //case 1:
    for (int i = 0; i < noAsteroids[0]; i++)
    {
      //AsteroidObject asteroid = new Asteroid(smallAstRad, random(width), random(200), 3);
      //asteroids.add(asteroid);
      //asteroid = new Asteroid(medAstRad, random(width), random(height, height - 200), 2);
      //asteroids.add(asteroid);
      AsteroidObject asteroid = new Asteroid(largeAstRad, random(200), random(height), 1);
      asteroids.add(asteroid);
    }
    //break;
 // }
  //AsteroidObject asteroid = new Asteroid(medAstRad, random(width), random(200), 3);
  //asteroids.add(asteroid); 
  //asteroid = new Asteroid(largeAstRad, random(200), random(height), 3);
  //asteroids.add(asteroid);
}

void mousePressed()
{
  //if (mouseX > width * 0.25f && mouseX < width * 0.75f)
  
}
void keyPressed()
{  
  keys[keyCode] = true;
  if (key >= '0' && key <= '1')
    level = key - '0';
}
void keyReleased()
{
  keys[keyCode] = false;
}

void draw()
{
  background(0);
  stroke(255);
  
  switch (level)
  {
    case 0:
      textSize(40);
      textAlign(CENTER);
      text("ASTEROIDS", width * 0.5f, height * 0.3f);
      asteroids.get(0).render();
      break;
    case 1:
      if (countdown != 0)
      {
        text(countdown, width * 0.5f, height * 0.3f);
        if (countdownTimer > 60)
        {
          countdown--;
          countdownTimer = 0;
        }
      }   
      else
      {
        gameStart = true;
      }
      if (gameStart != true)
        countdownTimer++;
      // Ship is the first element in list, therefore always render and update
      asteroids.get(0).render();
      asteroids.get(0).update();
      
      for (int i = 1; i < asteroids.size(); i++)
      {
        asteroids.get(i).render();
        // Only update (move) asteroids if the game has started
        if (gameStart)
          asteroids.get(i).update(); 
      }
      for (int i = 0; i < lasers.size(); i++)
      {
        if (gameStart)
        {
          lasers.get(i).render();
          lasers.get(i).update();
        }
      }
      break;
  }
}

void shipDeath(PVector pos, int radius)
{
  // Explosion on ship death
  int points = 12;
  if (radius < 60)
  {
    pushMatrix();
    translate(pos.x, pos.y);
    float thetaInc = TWO_PI / (points * 2);
    float lastX;
    float lastY;
    lastX = 0;
    lastY = -radius;
    stroke(255, 0, 0);
    for (int i = 1; i <= (points * 2); i ++)
    {
      float theta = i * thetaInc;
      float x, y;
      if (i % 2 == 1)
      {
        x = sin(theta) * (radius / 2.0f);
        y = -cos(theta) * (radius / 2.0f);
      }
      else
      {
        x = sin(theta) * radius;
        y = -cos(theta) * radius;
      }
      line(lastX, lastY, x, y);
      lastX = x;
      lastY = y;
    }
    popMatrix();
  }
  else
  {
    resetShip();
  }
}

void resetShip()
{
  asteroids.set(0, new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f));
  countdown = 3;
  gameStart = false;
}