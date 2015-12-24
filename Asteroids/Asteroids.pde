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
  medAstRad = 60;
  largeAstRad = 90;
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
PImage larAsteroid;
PImage medAsteroid;
PImage smallAsteroid;

boolean thrust;
int j, k;

void setupAsteroidObject()
{
  lasers.clear();
  asteroids.clear();
  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);
  
  // For first level, 5 big asteroids, 6 for 2nd, 7 for 3rd and so on
  for (int i = 0; i < noAsteroids[level - 1]; i++)
  {
    AsteroidObject asteroid = new Asteroid(random(200), random(height), 1);
    asteroids.add(asteroid);
  }
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

boolean exp = false;
int ex = SHIFT;

int resetTimer = 0;

void draw()
{
  background(0);
  stroke(255);
  
  // Start explosion experiment
  
  gameStart = true;
  asteroids.get(0).update();
  asteroids.get(0).render();
  
  if (keys[ex])
  {
    exp = true;
  }
  else
  {
    exp = false;
  }
  
  // End explosion experiment

  //if (level == 1)
  //{
  //  asteroids.get(0).render();
  //  fill(255);
  //  textSize(80);
  //  textAlign(CENTER);
  //  text("ASTEROIDS", width * 0.5f, height * 0.3f);
  //  if (mouseX > width * 0.35f && mouseX < width * 0.65f && mouseY > height * 0.7f && mouseY < height * 0.8f)
  //  {
  //    fill(0, 255, 0);
  //    textSize(50);
  //  }
  //  else
  //  {
  //    fill(255);
  //    textSize(40);
  //  }
  //  text("Start Game", width * 0.5f, height * 0.75f);
  //}
  //else if (level > 1)
  //{
  //  // 3.. 2.. 1.. Countdown to game start
  //  if (countdown != 0 && gameStart != true)
  //  {
  //    text(countdown + "..", width * 0.5f, height * 0.3f);
  //    if (countdownTimer > 60)
  //    {
  //      countdown--;
  //      countdownTimer = 0;
  //    }
  //  }
  //  else
  //  {
  //    gameStart = true;
  //    countdown = 3;
  //    countdownTimer = 0;
  //  }
    
  //  if (gameStart != true)
  //    countdownTimer++;
    
  //  // Ship is the first element in list, therefore always render and update
  //  asteroids.get(0).update();
  //  asteroids.get(0).render();
    
  //  if (asteroids.size() > 1)
  //  {
  //    for (int i = 0; i < asteroids.size(); i++)
  //    {
  //      asteroids.get(i).render();
  //      // Only update (move) asteroids if the game has started
  //      if (gameStart)
  //        asteroids.get(i).update();
  //    }
      
  //    for (int i = 0; i < lasers.size(); i++)
  //    {
  //      if (gameStart)
  //      {
  //        if (i > 0)
  //           lasers.get(i).colourSwap =! lasers.get(i - 1).colourSwap; 
  //        lasers.get(i).render();
  //        lasers.get(i).update();
  //      }
  //    }
  //  }
  //  else
  //  {
  //    gameStart = false;
  //    level++;
  //    setupAsteroidObject();
  //  }
  //}
}

void shipDeath(PVector pos, int radius, float angle)
{
  // Explosion on ship death
  int points = 13;
  //if (radius < 40)
  //{
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    float thetaInc = TWO_PI / (points * 2);
    float lastX = 0;
    float lastY = -radius;
    stroke(255, 0, 0);
    for (int i = 1; i <= (points * 2); i++)
    {
      float theta = i * thetaInc;
      float x, y;
      if (i % 2 == 1)
      {
        x = sin(theta) * (radius * 0.5f);
        y = -cos(theta) * (radius * 0.5f);
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
    resetTimer++;
    println(resetTimer);
  //}
  
  if (resetTimer > 120)
  {
    resetShip();
  }
}

void resetShip()
{
  asteroids.set(0, new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f));
  
  for (int i = 1; i < asteroids.size(); i++)
  {
    if (asteroids.get(i).position.x > width * 0.4f && asteroids.get(i).position.x < width * 0.6f
        && asteroids.get(i).position.y > height * 0.4f && asteroids.get(i).position.y < height * 0.6f)
    {
      asteroids.get(i).position.x = random(width);
      asteroids.get(i).position.y = random(200);
    }     
  }
}