import processing.sound.*;

SoundFile laserSound;
SoundFile thrustSound;
SoundFile explosionSound;

void setup()
{
  size(700, 600);
  smooth(8);
  for (int i = 0; i < 5; i++)
    noAsteroids[i] = i + 5;
  gameStart = false;
  level = 1;
  countdown = 3;
  countdownTimer = 0;
  smallAstRad = 30;
  medAstRad = 50;
  largeAstRad = 80;
  setupAsteroidObject();
  laserSound = new SoundFile(this, "shoot.wav");
  thrustSound = new SoundFile(this, "thrust.wav");
  explosionSound = new SoundFile(this, "expLarge.wav");

  thrust = true;
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

boolean thrust;
int j, k;

void setupAsteroidObject()
{
  lasers.clear();
  asteroids.clear();
  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);
  
  //// Twice as many small asteroids as medium (4 * as many as large ), so when a medium asteroid is hit, it splits into two small
  //for (int i = 0; i < noAsteroids[level - 1] * 4; i++)
  //{
  //  AsteroidObject asteroid = new Asteroid(smallAstRad, random(width), random(200), 3);
  //  asteroids.add(asteroid);
  //}
  
  //// Twice as many medium asteroids as large ones, so when a big asteroid is hit, it splits into two medium
  //for (int i = 0; i < noAsteroids[level - 1] * 2; i++)
  //{
  //  AsteroidObject asteroid = new Asteroid(medAstRad, random(width), random(height, height - 200), 2);
  //  asteroids.add(asteroid);
  //}
  
  //// For first level, 5 big asteroids, 6 for 2nd, 7 for 3rd and so on
  //for (int i = 0; i < noAsteroids[level - 1]; i++)
  //{
  //  AsteroidObject asteroid = new Asteroid(largeAstRad, random(200), random(height), 1);
  //  asteroids.add(asteroid);
  //}
  println(asteroids.size());
}

void mousePressed()
{
  if (mouseX > width * 0.35f && mouseX < width * 0.65f && mouseY > height * 0.7f && mouseY < height * 0.8f)
    level = 2;
}
void keyPressed()
{  
  if (gameStart)
    keys[keyCode] = true;
  if (key >= '1' && key <= '2')
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
  case 1:
    asteroids.get(0).render();
    fill(255);
    textSize(80);
    textAlign(CENTER);
    text("ASTEROIDS", width * 0.5f, height * 0.3f);
    if (mouseX > width * 0.35f && mouseX < width * 0.65f && mouseY > height * 0.7f && mouseY < height * 0.8f)
    {
      fill(0, 255, 0);
      textSize(50);
    } else
    {
      fill(255);
      textSize(40);
    }
    text("Start Game", width * 0.5f, height * 0.75f);
    break;
  case 2:

    if (countdown != 0)
    {
      text(countdown, width * 0.5f, height * 0.3f);
      if (countdownTimer > 60)
      {
        countdown--;
        countdownTimer = 0;
      }
    } else
    {
      gameStart = true;
    }
    if (gameStart != true)
      countdownTimer++;
    // Ship is the first element in list, therefore always render and update
    asteroids.get(0).render();
    asteroids.get(0).update();
    
    //for (int i = 1; i < asteroids.size(); i++)
    //{
    // println(asteroids.get(i).radius); 
    //}
    //println(asteroids.size() - noAsteroids[level - 2]);
    //for (int i = asteroids.size() - 1; i > asteroids.size() - 1 - noAsteroids[level - 2]; i--)
    //{
    //  println(i);
    //  println(asteroids.get(i).radius);
    //  asteroids.get(i).render();
    //  // Only update (move) asteroids if the game has started
    //  if (gameStart)
    //    asteroids.get(i).update();
    //}
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
      } else
      {
        x = sin(theta) * radius;
        y = -cos(theta) * radius;
      }
      line(lastX, lastY, x, y);
      lastX = x;
      lastY = y;
    }
    popMatrix();
  } else
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