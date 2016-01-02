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
  pause = false;
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
  reset = false;
  resetTimer = 0;
  lives = 5;
  livesHitCounter = 0;
  
  // Set all powerups to be false for beginning of game
  for (int i = 0; i < powerUps.length; i++)
    powerUps[i] = false;
  
  // PowerUp Timers
  
  powerupTimer = 600;
  
  // Time to enter onto screen
  entryTime = 150;//= int(random(300, 600));
  // Timer to time entry onto screen
  entryCountTimer = 0;
  
  powerupOnTimer = 0;
  
  power = new PowerUp(50, -20);
  
  enterPowerUp = false;
  powerupEnabled = false;
}

PowerUp power;

boolean[] keys = new boolean[512];
ArrayList<AsteroidObject> asteroids = new ArrayList<AsteroidObject>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
int[] noAsteroids = new int[5];
boolean gameStart;
int level;
int countdown;
int countdownTimer;
int largeAstRad;
int medAstRad;
int smallAstRad;
PImage larAsteroid;
PImage medAsteroid;
PImage smallAsteroid;
boolean thrust;
int j, k;
boolean reset;
int resetTimer;
int lives;
int livesHitCounter;

// 1 = double shooter, 2 = quad shooter, 3 = extra life, 4 = forcefield, 5 = empty (to change to once extra life has been added)
boolean[] powerUps = new boolean[5];
int powerup;
int powerupTimer;

int noPowerUps = 5;
// Time to enter onto screen
int entryTime;
// Timer to time entry onto screen
int entryCountTimer;
// Boolean array for if powerup is on screen or not. True = on screen.
boolean[] onScreen = new boolean[noPowerUps];

int powerupOnTimer;

boolean pause;

boolean enterPowerUp;
boolean powerupEnabled;

void draw()
{
  background(0);
  stroke(255);
  
  // Powerup stuff
  if (gameStart)
  {
    // Increment entry timer to know when to enter onto screen
    entryCountTimer++;
     
    // Once timer has reached time to enter, enter powerup onto screen
    if (entryCountTimer == entryTime)
    {
      // Select a random powerup
      //powerup = int(random(3));
      
      /* For now hard code to be first powerup (double shooter) for testing purposes */
      powerup = 0;
      // Set that powerup to be on screen
      onScreen[powerup] = true;
    }
    
    // Check to see if any powerups are supposed to be on screen 
    for (int i = 0; i < noPowerUps; i++)
    {
      if (onScreen[i])
      {
        // Call class to show powerup and move across screen
        power.render(powerup);
        power.update();
      }
    }
  }
      
  /*   
       // Choose random number: 0, 1, 2 or 3
       // Enable the corresponding powerup
       powerup = int(random(3));
       //powerUps[powerup] = true;
       println("PowerUp No.: " + powerup);
       if (powerup == 2)
       {
         if (lives < 10)
           lives++;
         powerup = 4;
       }
       
       //powerupCountTimer = 0;
       
       enterPowerUp = true;
     }
     
     if (enterPowerUp)
     {
       power.render(powerup);
       power.update();
     }
     
     // Once powerup has been enabled for 10 seconds, disable
     if (powerupEnabled)
     {
       powerUps[powerup] = true;
       powerupOnTimer++;
       if (powerupOnTimer == powerupTimer)
       {   
         powerUps[powerup] = false;
         powerupEnabled = false;
         powerupOnTimer = 0;
         powerupCountTimer = 0;
       }
     }
  }
  */
  
  if (level == 1)
  {
    asteroids.get(0).render();
    fill(255);
    textSize(80);
    textAlign(CENTER);
    text("ASTEROIDS", width * 0.5f, height * 0.3f);
    if (mouseX > width * 0.35f && mouseX < width * 0.65f && mouseY > height * 0.7f && mouseY < height * 0.8f)
    {
      fill(0, 255, 0);
      textSize(50);
    }
    else
    {
      fill(255);
      textSize(40);
    }
    text("Start Game", width * 0.5f, height * 0.75f);
  }
  else if (level > 1)
  {
    // 3.. 2.. 1.. Countdown to game start
    if (countdown != 0 && gameStart != true)
    {
      textSize(40);
      text(countdown + "..", width * 0.5f, height * 0.3f);
      if (countdownTimer > 60)
      {
        countdown--;
        countdownTimer = 0;
      }
    }
    // Only start game if pause is not active
    else if (pause == false)
    {
      gameStart = true;
    }

    if (gameStart != true)
      countdownTimer++;

    // Ship is the first element in list, therefore always render and update
    asteroids.get(0).update();
    asteroids.get(0).render();

    if (asteroids.size() > 1)
    {
      for (int i = 0; i < asteroids.size(); i++)
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
          if (i > 0)
            lasers.get(i).colourSwap =! lasers.get(i - 1).colourSwap; 
          lasers.get(i).render();
          lasers.get(i).update();
        }
      }
    }
    else
    {
      gameStart = false;
      level++;
      setupAsteroidObject();
      countdown = 3;
      countdownTimer = 0;
      powerupCountTimer = 0;
      powerUps[powerup] = false;
    }
  }
  
  // Show the user how many lives they have
  drawShipLives();
  
  // Show user the current level
  fill(255);
  textSize(25);
  if (level > 1)
    text("Level " + (level - 1), width * 0.5f, height * 0.065f);
}

void setupAsteroidObject()
{
  lasers.clear();
  asteroids.clear();
  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);

  // For first level, 5 big asteroids, 6 for 2nd, 7 for 3rd and so on
  for (int i = 0; i < noAsteroids[level - 1]; i++)
  {
    AsteroidObject asteroid;
    if (i % 2 == 0)
      asteroid = new Asteroid(random(200), random(height), 1);
    else
      asteroid = new Asteroid(random(width - 200, width), random(height), 1);
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
  
  // Enable PowerUp
  if (keyCode == 'Z')
    powerupEnabled = true;
  
  // Pause/Unpause game when P is pressed
  if (keyCode == 'P')
  {
    // If countdown has stopped (i.e. game has started), set pause and gameStart to be opposite to their current values, hence pausing the game
    if (countdown == 0)
    {
      pause =! pause;
      gameStart =! gameStart;
    }
  }
}
void keyReleased()
{
  keys[keyCode] = false;
}

// Draw player lives as ships in top left corner of screen
void drawShipLives()
{
  float drawHeight = 13;
  float drawWidth = drawHeight * 0.7f;
  
  for (int i = 0; i < lives; i++)
  {
    pushMatrix();
    translate((i + 1) * 25, 30);
    stroke(0, 206, 209);
    line(0, -drawHeight, -drawWidth, drawHeight);
    line(0, -drawHeight, drawWidth, drawHeight);
    line(-drawWidth * 0.75f, drawHeight * 0.7f, drawWidth * 0.75f, drawHeight * 0.7f);
    popMatrix();
  } 
}

void shipDeath(PVector pos, int radius, float angle)
{
  // Explosion on ship death
  int points = 13;
  if (resetTimer < 120)
  {
    for (int i = 0; i < keys.length; i++)
      keys[i] = false;
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
    resetTimer++;
  }
  else
  {
    resetShip();
  }
}

void resetShip()
{
  asteroids.set(0, new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f));

  for (int i = 1; i < asteroids.size(); i++)
  {
    if (asteroids.get(i).position.x > width * 0.3f &&
      asteroids.get(i).position.x < width * 0.7f && 
      asteroids.get(i).position.y > height * 0.3f &&
      asteroids.get(i).position.y < height * 0.7f)
    {
      asteroids.get(i).position.x = random(width);
      asteroids.get(i).position.y = random(200);
    }
  }
  reset = true;
  countdown = 3;
  resetTimer = 0;
  livesHitCounter = 0;
}