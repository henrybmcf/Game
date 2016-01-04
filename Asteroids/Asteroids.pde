//import processing.sound.*;

//SoundFile intro;
//SoundFile countdownSound;
//SoundFile laserSound;
//SoundFile thrustSound;
//SoundFile explosionSound;
//SoundFile nukeSound;

void setup()
{
  size(700, 600);
  //fullScreen();
  smooth(8);
  strokeWeight(1.5);
  //levels = 6;
  for (int i = 0; i < levels; i++)
    noAsteroids[i] = i + 5;
  gameStart = false;
  pause = false;
  level = 1;
  countdown = 1;
  countdownTimer = 0;
  smallAstRad = 30;
  medAstRad = 60;
  largeAstRad = 90;
  setupAsteroidObject();
  //intro = new SoundFile(this, "introMusic.wav");
  //intro.rate(0.4);
  //intro.play();
  //countdownSound = new SoundFile(this, "countdown.mp3");
  //laserSound = new SoundFile(this, "shoot.wav");
  //thrustSound = new SoundFile(this, "thrust.wav");
  //explosionSound = new SoundFile(this, "expLarge.wav");
  //nukeSound = new SoundFile(this, "nuke.wav"); 
  thrust = true;
  reset = false;
  resetTimer = 0;
  lives = 5;
  livesHitCounter = 0;
  shipAlive = true;
  score = 0;

  power = new PowerUp(random(width), -20);
  // Enter powerup onto screen after random time between 5 & 10 seconds.
  entryTime = 100;//int(random(300, 600));
  // Timer to time entry onto screen
  entryCountTimer = 0;
  // Initiliase onScreen, collected & activated boolean arrays to be false for start of game 
  for (int i = 0; i < noPowerUps; i++)
  {
    onScreen[i] = false;
    collected[i] = false;
    activated[i] = false;
  }
  // Timer to time how long powerup has been active and to subsequently deactivate
  activeTimer = 0;
  // Deactivate powerup after 5 seconds
  deactivateTime = 300;

  nukeRadius = 30;
  nukeTimer = 0;

  powerupSymbol = 30;
  nukeSymbol = powerupSymbol * 0.9f;
  
  red = color(255, 0, 0);
  yellow = color(255, 255, 0);
  aqua = color(0, 206, 209);
  
  powerupLifeHeight = 10;
  powerupLifeWidth = powerupLifeHeight * 0.7f;
  
  nukePos = new PVector(0, 0);
}

PVector nukePos;

boolean[] keys = new boolean[512];
ArrayList<AsteroidObject> asteroids = new ArrayList<AsteroidObject>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
int levels = 6;
int[] noAsteroids = new int[levels];
boolean gameStart;
// Boolean to set game to a paused state
boolean pause;
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
boolean shipAlive;
int score;

PowerUp power;
// Integer to select powerup
int powerup;
// 1 = double shooter, 2 = quad shooter, 3 = Nuke, 4 = extra life, 5 = forcefield
int noPowerUps = 6;
// Time to enter onto screen
int entryTime;
// Timer to time entry onto screen
int entryCountTimer;
// Boolean array for if powerup is on screen or not. True = on screen.
boolean[] onScreen = new boolean[noPowerUps];
// Boolean array for if powerup has been collected by ship
boolean[] collected = new boolean[noPowerUps];
// Boolean array for is powerup has been activated
boolean[] activated = new boolean[noPowerUps];
// Time how long powerup has been active and to subsequently deactivate
int activeTimer;
// Time to deactivate powerup
int deactivateTime;

float nukeRadius;
int nukeTimer;

int powerupSymbol;
float nukeSymbol;

color red;
color yellow;
color aqua;
  
int powerupLifeHeight;
float powerupLifeWidth;

void draw()
{
  background(0);
  stroke(255);

  if (level == 1)
  {
    asteroids.get(0).render();
    fill(255);
    textSize(80);
    textAlign(CENTER);
    text("ASTEROIDS", width * 0.5f, height * 0.3f);
    if (mouseX > width * 0.35f && mouseX < width * 0.65f && mouseY > height * 0.7f && mouseY < height * 0.8f)
    {
      fill(yellow);
      textSize(45);
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
      fill(255);
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
     // countdownSound.stop();
      shipAlive = true;
      gameStart = true;
    }

    if (gameStart != true)
      countdownTimer++;

    // Ship is the first element in list, therefore always render and update
    asteroids.get(0).update();
    asteroids.get(0).render();

    if (asteroids.size() > 1)
    {
      for (int i = 1; i < asteroids.size(); i++)
      {
        asteroids.get(i).render();
        // Only update (move) asteroids if the game has started
        if (gameStart && activated[4] == false)
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
      // Set all keys to false, so player cannot move ship
      for (int i = 0; i < keys.length; i++)
        keys[i] = false;
      if (level < levels)
      {
        level++;
        // Player gets an extra life for each level they pass after level 2
        if (level > 2)
          lives++;
        setupAsteroidObject();
        countdown = 3;
        countdownTimer = 0;

        // Deactivate all currently activated powerups
        for (int i = 0; i < noPowerUps; i++)
        {
          activated[i] = false;
          activeTimer = 0;
        }
      }
      else
      {
        playAgain(true);
      }
    }
  }

  // Powerup timing, collection and activations
  if (gameStart)
  {
    // Increment entry timer to know when to enter onto screen
    entryCountTimer++;    
    // Once timer has reached time to enter, enter powerup onto screen
    if (entryCountTimer == entryTime)
    {
      // Select a random powerup
      powerup = 4;
      //int(random(noPowerUps));   
      // Set that powerup to be on screen
      onScreen[powerup] = true;
    }

    // Check to see if any powerups are supposed to be on screen or are active
    for (int i = 0; i < noPowerUps; i++)
    {
      //if (onScreen[i])
      //{
      //  // Call class to show powerup and move across screen
      //  power.render(powerup);
      //  power.update();
      //}
      
      // If they are, start timing how long they have been active for
      if (activated[i])
      {      
        // Once they reach the time limit, deactivate the powerup and reset the timer
        if (activeTimer == deactivateTime)
        {
          activated[i] = false;
          activeTimer = 0;
        }
        activeTimer++;
      }
    }
  }

  // Draw the collected powerup symbols in the top right corner
  for (int i = 0; i < noPowerUps; i++)
  {
    if (onScreen[i])
    {
      // Call class to show powerup and move across screen (if game is running)
      power.render(powerup);
      if (gameStart)
        power.update();
    }
    
    if (collected[i])
    {
      pushMatrix();
      translate(width - ((i + 1) * 40), height * 0.05f);
      drawPowerupSymbols(i);
      popMatrix();
    }
  }

  // Show the user how many lives they have
  drawShipLives();

  // Show user the current level
  fill(255);
  textSize(25);
  if (level > 1)
    text("Level " + (level - 1), width * 0.5f, height * 0.065f);

  // Show user their current score
  text(score, width * 0.95f, height * 0.95f);
}

void drawPowerupSymbols(int ID)
{
  fill(0);
  stroke(aqua);
  ellipse(0, 0, powerupSymbol, powerupSymbol);
  
  switch(ID)
  {
    // Double Shooter
    case 0:
      fill(red);
      stroke(red);
      ellipse(5, 0, 3, 3);
      fill(yellow);
      stroke(yellow);
      ellipse(-5, 0, 3, 3);
      break;
    // Quad Shooter
    case 1:
      fill(red);
      stroke(red);
      ellipse(-5, -5, 2, 2);
      ellipse(5, 5, 2, 2);
      fill(yellow);
      stroke(yellow);
      ellipse(5, -5, 2, 2);
      ellipse(-5, 5, 2, 2);
      break;
    // Nuke
    case 2:
      float beta = TWO_PI / 6;
      stroke(yellow);
      fill(yellow);
      arc(0, 0, nukeSymbol, nukeSymbol, beta, beta * 2.0f);
      arc(0, 0, nukeSymbol, nukeSymbol, PI, PI + beta);
      arc(0, 0, nukeSymbol, nukeSymbol, TWO_PI - beta, TWO_PI);
      stroke(0);
      ellipse(0, 0, powerupSymbol * 0.15f, powerupSymbol * 0.15f);
      break;
    // Forcefield
    case 3:
      stroke(yellow);
      ellipse(0, 0, powerupSymbol * 0.8f, powerupSymbol * 0.8f);
      ellipse(0, 0, powerupSymbol * 0.6f, powerupSymbol * 0.6f);
      ellipse(0, 0, powerupSymbol * 0.4f, powerupSymbol * 0.4f);
      break;
    // Freeze
    case 4:
      stroke(255);
      pushMatrix();
      for (int i = 0; i < 6; i++)
      {     
        line(0, 0, 0, powerupSymbol * 0.4f);
        pushMatrix();
        translate(0, powerupSymbol * 0.2f);
        rotate(PI * 0.2f);
        line(0, 0, 0, powerupSymbol * 0.2f);
        rotate(-PI * 0.4f);
        line(0, 0, 0, powerupSymbol * 0.2f);
        popMatrix();
        rotate(PI / 3);
      }
      popMatrix();
      break;
    // Extra Life
    case 5:
     stroke(aqua);
     line(0, -powerupLifeHeight, -powerupLifeWidth, powerupLifeHeight);
     line(0, -powerupLifeHeight, powerupLifeWidth, powerupLifeHeight);
     line(-powerupLifeWidth * 0.75f, powerupLifeHeight * 0.7f, powerupLifeWidth * 0.75f, powerupLifeHeight * 0.7f);
     break; 
  }
}

void playAgain(boolean win)
{
  gameStart = false;
  fill(255);
  textSize(35);
  // Add 25 points to score per life
  score += lives * 25;
  text("Your Score: " + score, width * 0.5f, height * 0.4f);
  textSize(40);
  if (win)
    text("YOU WIN", width * 0.5f, height * 0.3f);
  else
    text("GAME OVER", width * 0.5f, height * 0.3f);
  text("Play Again?", width * 0.5f, height * 0.6f);
  text("Yes", width * 0.3f, height * 0.8f);
  text("No", width * 0.7f, height * 0.8f);

  // If they select to play again, setup asteroids and reset level
  // Otherwise, exit the game
  if (mousePressed)
  {
    if (mouseY > height * 0.7f && mouseY < height * 0.9f)
    {
      if (mouseX > width * 0.15f && mouseX < width * 0.45f)
      {
        score = 0;
        level = 1;
        lives = 5;
        setupAsteroidObject();
      }
      else if (mouseX > width * 0.55f && mouseX < width * 0.85f)
      {
        exit();
      }
    }
  }
}

void setupAsteroidObject()
{
  lasers.clear();
  asteroids.clear();
  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);

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
  {
    level = 2;
    //intro.stop();
    //countdownSound.play();
  }
}
void keyPressed()
{
  if (keyCode == ' ' && level == 1)
    level++;
    
  if (gameStart)
    keys[keyCode] = true;
  
  if (shipAlive)
  {
    // Enable relevant powerup when key pressed if within collection and not already activated
    if (key >= '1' && key <= '5')
    {
      if (collected[key - '0' - 1] && activated[key - '0' - 1] == false)
      {
        // Set powerup to be activated and remove from collection
        activated[key - '0' - 1] = true;
        collected[key - '0' - 1] = false;
        
        // If nuke power up selected, set current ship position to be nuke drop location
        if (key - '0' == 3)
        {
          nukePos = asteroids.get(0).position.copy();
          nukeRadius = 30;
        }
      }
    }
  }

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
    stroke(aqua);
    line(0, -drawHeight, -drawWidth, drawHeight);
    line(0, -drawHeight, drawWidth, drawHeight);
    line(-drawWidth * 0.75f, drawHeight * 0.7f, drawWidth * 0.75f, drawHeight * 0.7f);
    popMatrix();
  }
}

void shipDeath(int radius, float angle)
{
  shipAlive = false;
  
  // Explosion on ship death
  int points = 15;
  if (resetTimer < 300)
  {
    // Set all keys to false, so player cannot move ship
    for (int i = 0; i < keys.length; i++)
      keys[i] = false;
    pushMatrix();
    translate(asteroids.get(0).position.x, asteroids.get(0).position.y);
    rotate(angle);
    float thetaInc = TWO_PI / (points * 2);
    float lastX = 0;
    float lastY = -radius;
    stroke(red);
    for (int i = 1; i <= (points * 2); i++)
    {
      float theta = i * thetaInc;
      float x, y;
      if (i % 2 == 1)
      {
        x = sin(theta) * (radius * 0.8f);
        y = -cos(theta) * (radius * 0.8f);
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
  reset = true;
  asteroids.set(0, new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f));

  // Move any asteroids in centre of screen to edges to give player a far chance on respawn
  for (int i = 1; i < asteroids.size(); i++)
  {
    if (asteroids.get(i).position.x > width * 0.3f && asteroids.get(i).position.x < width * 0.7f && 
      asteroids.get(i).position.y > height * 0.3f && asteroids.get(i).position.y < height * 0.7f)
    {
      asteroids.get(i).position.x = random(width);
      asteroids.get(i).position.y = random(200);
    }
  }

  // Reset countdown;
  countdown = 3;
  resetTimer = 0;
  livesHitCounter = 0;

  // Reset any currently activated powerups to be false (deactivated)
  for (int i = 0; i < noPowerUps; i++)
  {
    if (activated[i])
      activated[i] = false;
    activeTimer = 0;
  }
}

void nukeExplosion(float angle)
{
  int points = 15;
  pushMatrix();
  translate(nukePos.x, nukePos.y);
  rotate(angle);
  float thetaInc = TWO_PI / (points * 2);
  float lastX = 0;
  float lastY = -nukeRadius;
  stroke(red);
  for (int i = 1; i <= (points * 2); i++)
  {
    float theta = i * thetaInc;
    float x, y;
    if (i % 2 == 1)
    {
      x = sin(theta) * (nukeRadius * 0.95f);
      y = -cos(theta) * (nukeRadius * 0.95f);
    } else
    {
      x = sin(theta) * nukeRadius;
      y = -cos(theta) * nukeRadius;
    }
    line(lastX, lastY, x, y);
    lastX = x;
    lastY = y;
  }
  popMatrix();
}

void splitAsteroid(int number)
{
  //explosionSound.play();
  if (asteroids.get(number).radius == 90)
  {
    score += 5;
    if (asteroids.size() < 27)
    {
      AsteroidObject asteroid = new Asteroid(asteroids.get(number).position.x, asteroids.get(number).position.y, 2);
      asteroids.add(asteroid);
    }
    if (asteroids.size() < 27)
    {
      AsteroidObject asteroid = new Asteroid(asteroids.get(number).position.x, asteroids.get(number).position.y, 2);
      asteroids.add(asteroid);
    }
  }
  else if (asteroids.get(number).radius == 60)
  {
    score += 10;
    if (asteroids.size() < 27)
    {
      AsteroidObject asteroid = new Asteroid(asteroids.get(number).position.x, asteroids.get(number).position.y, 3);
      asteroids.add(asteroid);
    } 
    if (asteroids.size() < 27)
    {
      AsteroidObject asteroid = new Asteroid(asteroids.get(number).position.x, asteroids.get(number).position.y, 3);
      asteroids.add(asteroid);
    }
  }
  else if (asteroids.get(number).radius == 30)
  {
    score += 15;
  }
  asteroids.remove(number);
}