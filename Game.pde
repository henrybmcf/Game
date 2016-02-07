import processing.sound.*;
import java.io.FileWriter;
import java.io.BufferedWriter;

void setup()
{
  size(700, 600);
  //fullScreen();
  smooth(8);
  strokeWeight(1.5);
  cursor(CROSS);

  // Load the intro soundtrack and start playing
  introSound = new SoundFile(this, "introMusic.wav");
  introSound.rate(0.4);
  playSound(1);
  countdownSound = new SoundFile(this, "countdown.mp3");
  laserSound = new SoundFile(this, "shoot.wav");
  thrustSound = new SoundFile(this, "thrust.wav");
  explosionSound = new SoundFile(this, "explosion.wav");
  shipDestructionSound = new SoundFile(this, "shipDestruction.mp3");
  alienDestructionSound = new SoundFile(this, "alienDestruction.mp3");
  powerupCollectionSound = new SoundFile(this, "powerupCollect.mp3");
  powerupActivationSound = new SoundFile(this, "powerupActivate.mp3");
  //nukeSound = new SoundFile(this, "nuke.wav");
  //forcefieldPowerupSound = new SoundFile(this, ".wav");
  //freezePowerupSound = new SoundFile(this, ".wav");
  //gameWinSound = new SoundFile(this, ".wav");
  //gameOverSound = new SoundFile(this, ".wav");

  instructions = new Instructions();
  showInstruction = false;
  // Create new font called hyperspace and set as font for whole sketch
  hyperspace = createFont("HyperspaceBold.otf", 32);
  textFont(hyperspace, 32);
  keys = new boolean[512];
  asteroids = new ArrayList<AsteroidObject>();
  lasers = new ArrayList<Laser>();
  levels = 10;
  level = 1;
  noAsteroids = new int[levels];
  // Set the number of asteroids per level to be the level number plus 5.
  for (int i = 0; i < levels; i++)
    noAsteroids[i] = i + 1;
  overStart = false;
  gameStart = false;
  gameEnd = false;
  pause = false;
  mute = false;
  countdown = 3;
  countdownTimer = 0;
  // Set the sizes of the asteroids
  smallAstRad = 30;
  medAstRad = 60;
  largeAstRad = 90;
  // Call method to setup the arraylist of asteroids
  setupAsteroidObject();
  reset = false;
  resetTimer = 0;
  lives = 3;
  livesHitCounter = 0;
  shipAlive = true;
  aliens = new ArrayList<AlienObjects>();
  alienLasers = new ArrayList<AlienLaser>();
  AlienObjects alienship = new AlienSpaceShip(int(random(1, 5)));
  aliens.add(alienship);
  enterAlien = false;
  alienEntryTime = int(random(200, 300));
  alienTimer = 0;  
  shipDebrisPositions = new ArrayList<PVector>();
  shipDebrisMovements = new ArrayList<PVector>();
  for (int i = 0; i < 5; i++)
  {
    shipDebrisPositions.add(new PVector(0, 0)); 
    shipDebrisMovements.add(new PVector(0, 0));
  }
  asteroidDebrisPosition = new ArrayList<PVector>();
  asteroidDebrisMovement = new ArrayList<PVector>();
  // Random movements for all debris particles
  asteroidDebrisMovement.add(new PVector(0, random(-1)));
  asteroidDebrisMovement.add(new PVector(random(0.75), random(-1.2)));
  asteroidDebrisMovement.add(new PVector(random(1.2), 0));
  asteroidDebrisMovement.add(new PVector(0, random(0.8)));
  asteroidDebrisMovement.add(new PVector(random(-0.5), 1));
  asteroidDebrisMovement.add(new PVector(random(1), random(0.5)));
  shipDead = false;
  debris = false;
  debrisTimer = 0;
  times = new IntList();
  score = 0;
  scores = new IntList();
  players = new StringList();
  playerArray = new String[5];
  typeTimer = 0;
  showHighScores = false;
  playAgain = false;
  playerName = "";
  power = new PowerUp(random(width), -20);
  noPowerUps = 7;
  // Enter powerup onto screen after random time between 5 & 7 seconds.
  pUpEntryTimeLimit = int(random(300, 420));
  pUpEntryTimer = 0; 
  onScreen = new boolean[noPowerUps];
  collected = new boolean[noPowerUps];
  activated = new boolean[noPowerUps];
  // Initiliase onScreen, collected & activated boolean arrays to be false for start of game 
  for (int i = 0; i < noPowerUps; i++)
  {
    onScreen[i] = false;
    collected[i] = false;
    activated[i] = false;
  }
  activeTimer = 0;
  deactivateTime = 360;
  powerupSymbol = 30;
  nukeRadius = 30;
  nukeTimer = 0;
  nukeSymbol = powerupSymbol * 0.9f;
  nukePos = new PVector(0, 0);
  powerupLifeHeight = 10;
  powerupLifeWidth = powerupLifeHeight * 0.7f;
  red = color(255, 0, 0);
  yellow = color(255, 255, 0);
  aqua = color(0, 206, 209);
}

// Various sound effect variables
SoundFile introSound;
SoundFile countdownSound;
SoundFile laserSound;
SoundFile thrustSound;
SoundFile explosionSound;
SoundFile shipDestructionSound;
SoundFile alienDestructionSound;
SoundFile powerupCollectionSound;
SoundFile powerupActivationSound;
SoundFile nukeSound;
SoundFile forcefieldPowerupSound;
SoundFile freezePowerupSound;
SoundFile gameWinSound;
SoundFile gameOverSound;
// Variables to show instructions screen
Instructions instructions;
boolean showInstruction;
// Custom font
PFont hyperspace;
// Boolean array to allow multiple simultaneous key presses and determine which keys they are
boolean[] keys;
// ArrayList of ship and all asteroids in game
ArrayList<AsteroidObject> asteroids;
// ArrayList of all lasers in game
ArrayList<Laser> lasers;
// Number of levels in the game
int levels;
// Variable for the level number
int level;
// Array to hold number of asteroids per level
int[] noAsteroids;
// Boolean to determine if mouse is over start game when pressed
boolean overStart;
// Boolean to determine if game has started or not
boolean gameStart;
// Boolean to determine if game is over
boolean gameEnd;
// Boolean to set game to a paused state
boolean pause;
// Boolean to determine if game is muted or not
boolean mute;
// Variables for countdown to start of each level
int countdown;
int countdownTimer;
// Variables for sizes of different asteroids
int largeAstRad;
int medAstRad;
int smallAstRad;
// Boolean to determine if game has been reset or not
boolean reset;
int resetTimer;
// Number of lives
int lives;
int livesHitCounter;
// Boolean to determine if ship is alive
boolean shipAlive;
// Arraylists of alien spaceship and alien lasers
ArrayList<AlienObjects> aliens;
ArrayList<AlienLaser> alienLasers;
// Boolea to determine if alien space ship is alive or dead
boolean alienShipDead;
// Boolea to determine if alien spaceship should enter onto screen
boolean enterAlien;
// Variables to time entry of alien spaceship on screen
int alienEntryTime;
int alienTimer;
// Vectors to hold position and movements of debris upon ship destruction
ArrayList<PVector> shipDebrisPositions;
ArrayList<PVector> shipDebrisMovements;
// Vectors to hold position and movements of rock debris upon asteroid or alien ship destruction
ArrayList<PVector> asteroidDebrisPosition;
ArrayList<PVector> asteroidDebrisMovement;
// Boolean to determine if ship is dead, to know when to activate ship destruction animation
boolean shipDead;
// Boolean to determine to show rock debris animation
boolean debris;
// Variable to time rock debris animation
int debrisTimer;
// List of times to execute and remove rock debris
// This allows multiple rock debris animations simultaneously
IntList times;
// Variable to hold player's score
int score;
// Integer list of previous scores
IntList scores;
// String list of previous player names
StringList players;
// String array of names of top five scoring players
String[] playerArray;
// Variable to time flashing of typing line when entering name for highscore 
int typeTimer;
// Booleans to perform certain actions upon completion of other actions, in this case show high score screen and option to play again
boolean showHighScores;
boolean playAgain;
// Variables to enable writing of highscores to text file
PrintWriter scoring;
String playerName;
// Variables to enable reading of highscores in text file
BufferedReader reader;
Table scoreTable;
String line;
// PowerUp variable
PowerUp power;
// Integer to select powerup
int powerup;
// 1(0) = Double Shooter, 2(1) = Quad Shooter, 3(2) = Nuke, 4(3) = Forcefield, 5(4) = Freeze, 6(5) = Extra Life, 7(6) = Rapid Fire
int noPowerUps;
// Time for powerup to enter onto screen
int pUpEntryTimeLimit;
// Timer to time powerup entry onto screen
int pUpEntryTimer;
// Boolean array for if powerup is on screen or not. True = on screen.
boolean[] onScreen;
// Boolean array for if powerup has been collected by ship
boolean[] collected;
// Boolean array for is powerup has been activated
boolean[] activated;
// Time how long powerup has been active and to subsequently deactivate
int activeTimer;
// Time to deactivate powerup
int deactivateTime;
// Size of powerup symbol
int powerupSymbol;
// Radius of and nuclear blast and timer to control expansion rate
float nukeRadius;
int nukeTimer;
// Size of nuclear symbol within powerup symbol
float nukeSymbol;
// Position of nuclear explosion
PVector nukePos;
// Size of extra life symbol within powerup symbol
int powerupLifeHeight;
float powerupLifeWidth;
// Colour variables
color red;
color yellow;
color aqua;

void draw()
{ 
  background(2);
  stroke(255);
  textAlign(CENTER);

  // Start game screen
  if (level == 1)
  {
    asteroids.get(0).render();
    fill(255);
    textSize(80);
    text("ASTEROIDS", width * 0.5f, height * 0.3f);
    textSize(25);
    text("I = Instructions", width * 0.5f, height * 0.9f);
    textSize(45);
    fill(yellow);
    text("Start Game", width * 0.5f, height * 0.75f); 
    if (showInstruction == false)
    {
      // If mouse position is over Start Game, change mouse icon to indicate to player they can press
      float startWidth = textWidth("Start Game") * 0.5f;
      if (mouseX > width * 0.5f - startWidth && mouseX < width * 0.5f + startWidth && mouseY > height * 0.7f && mouseY < height * 0.75f)
      {
        cursor(HAND);
        overStart = true;
      }
      else
      {
        cursor(CROSS);
        overStart = false;
      }
    }
  }
  else if (level > 1)
  {
    noCursor();
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
      countdownSound.stop();
      shipAlive = true;
      gameStart = true;
    }

    // If instruction screen is showing, stop timer that controls countdown to effectively pause the countdown
    if (gameStart != true && showInstruction == false)
      countdownTimer++;

    // Ship is the first element in list, therefore always render and update, unless game is paused or ship is dead
    if (gameEnd == false && shipDead == false)
      asteroids.get(0).render();
    if (pause == false)
      asteroids.get(0).update();

    // Check to see if there are still asteroids on screen to be destroyed
    if (asteroids.size() > 1)
    {
      if (gameEnd == false)
      {
        // Show and move asteroids
        for (int i = 1; i < asteroids.size(); i++)
        {
          asteroids.get(i).render();
          // Only update (move) asteroids if the game has started and freeze powerup is not active
          if (gameStart && activated[4] == false)
            asteroids.get(i).update();
        }
      }
      
      // Show, move and control colour of player's lasers
      for (int i = 0; i < lasers.size(); i++)
      {
        if (i > 0)
          lasers.get(i).colourSwap =! lasers.get(i - 1).colourSwap; 
        lasers.get(i).render();
        if (gameStart)
          lasers.get(i).update();
      }
      
      // Timing entry of alien spaceship 
      if (alienTimer > alienEntryTime)
      {
        alienTimer = 0;
        // Set entry boolean to be true to let the alien ship know when to enter
        enterAlien = true;
      }
      if (gameStart)
        alienTimer++;
    
      // Drawing and moving alien ship
      if (enterAlien && alienShipDead != true)
      {
        aliens.get(0).render();
        if (pause == false && gameStart)
          aliens.get(0).update();
      }
      
      // Drawing and moving alien lasers
      for (int i = 0; i < alienLasers.size(); i++)
      {
        alienLasers.get(i).render();
        if (gameStart)
          alienLasers.get(i).update();
      }
    }
    else
    {
      gameStart = false;
      // Set all keys to false, so player cannot move ship
      for (int i = 0; i < keys.length; i++)
        keys[i] = false;
      // If maximum level has not been reached (if game has not been completed)
      if (level < levels)
      {
        level++;
        // Player gets an extra life for each level they pass after level 2
        if (level > 3 && lives < 5)
          lives++;
        // Setup asteroids for next level and reset countdown
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
      else if (showHighScores != true)
      {
        gameOver(true);
      }
    }
  }
  
  // Show the user how many lives they have
  drawShipLives();

  // Show user the current level
  fill(255);
  textSize(25);
  if (level > 1 && gameEnd == false)
    text("Level " + (level - 1), width * 0.5f, height * 0.065f);

  // Show user their current score
  text(score, width * 0.95f, height * 0.95f);

  // Show play again menu
  if (playAgain)
    playAgain();
  
  // Show instruction screen
  if (showInstruction)
    instructions.render();

  // Powerup timing, collection and activations
  if (gameStart && gameEnd == false)
  {
    // Increment entry timer to know when to enter onto screen
    pUpEntryTimer++;

    // Once timer has reached time to enter, enter powerup onto screen
    if (pUpEntryTimer == pUpEntryTimeLimit)
    {
      // Select a random powerup
      powerup = int(random(noPowerUps));
      // Set that powerup to be on screen
      onScreen[powerup] = true;
    }

    // Check to see if any powerups are supposed to be on screen or are active
    for (int i = 0; i < noPowerUps; i++)
    {
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

  // Check which powerups are on screen (to be collected) and have been collected
  for (int i = 0; i < noPowerUps; i++)
  {
    // Call class to show powerup and move across screen (if game is running)
    if (onScreen[i])
    {
      if (gameEnd != true)
        power.render(powerup);
      if (gameStart)
        power.update();
    }
    
    // Draw the collected powerup symbols in the top right corner
    if (collected[i])
    {
      pushMatrix();
      translate(width - ((i + 1) * 40), height * 0.05f);
      drawPowerupSymbols(i);
      popMatrix();
    }
  }
  
  if (activated[4])
    playSound(12);

  // Draw rock debris
  if (debris)
    debris();
  debrisTimer++;
} // End Draw


void setupAsteroidObject()
{
  // Clear all lasers and asteroids from the screen
  lasers.clear();
  asteroids.clear();
  // Reset the ship to be in the center of the screen for the next level
  AsteroidObject ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);

  // Load correct number of asteorids for the level
  for (int i = 0; i < noAsteroids[level - 1]; i++)
  {
    AsteroidObject asteroid;
    if (i % 2 == 0)
      asteroid = new Asteroid(random(200), random(height), 1);
    else
      asteroid = new Asteroid(random(width - 200, width), random(height), 1);
    asteroids.add(asteroid);
  }
} // End Setup Asteroid Objects


void keyPressed()
{
  // Press space bar to start game on intro screen
  if (keyCode == ' ' && level == 1)
  {
    level = 2;
    introSound.stop();
    playSound(2);
  }

  if (gameStart)
    keys[keyCode] = true;

  if (shipAlive)
  {
    // Enable relevant powerup when key pressed if within collection and not already activated
    if (key >= '1' && key <= '6')
    {
      if (collected[key - '0' - 1] && activated[key - '0' - 1] == false)
      {
        // Play powerup activation sound
        playSound(9);
        
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

  // Mute/Unmute sounds when M is pressed
  if (keyCode == 'M' && gameEnd == false)
  {
    mute =! mute;
    if (mute)
    {
      introSound.stop();
      countdownSound.stop();
      explosionSound.stop();
      thrustSound.stop();
      laserSound.stop();
      nukeSound.stop();
    }
  }

  // Pause/Unpause game when P is pressed
  if (keyCode == 'P' && gameEnd == false)
  {
    // If countdown has stopped (i.e. game has started), set pause and gameStart to be opposite to their current values, hence pausing the game
    if (countdown == 0)
    {
      pause =! pause;
      gameStart =! gameStart;
    }
  }

  // Show/Hide instruction screen
  if (keyCode == 'I' && gameEnd == false)
  {
    showInstruction =! showInstruction;
    // pause =! pause;
    if (pause != true)
      pause = true;
    else if (pause)
      pause = true;
    if (showInstruction)
      gameStart = false;
  }
  
  // If game has ended, any keys pressed will be for entering name for highscore
  if (gameEnd)
  {
    // Delete last typed letter of name if backspace hit and length is greater than zero
    if (keyCode == BACKSPACE && playerName.length() > 0)
    {
      playerName = playerName.substring(0, playerName.length()-1);
    }
    // As long as the key is not a commonly used 'extra' key and the length is less than characters, add the typed key ot the player name
    else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != ENTER && keyCode != RETURN && playerName.length() < 10)
    {
      playerName = playerName + key;
    }
    // Upon enter key being pressed and the name containing some characters, pass to the file
    else if (keyCode == ENTER && playerName.length() > 0)
    {
      // Write player's name and score to file, using this method allows appending to previously created file
      // Allowing you to view highscores from previous sessions
      try
      {
        // Path to scores.csv must be full path, meaning you must change this on each computer in order to run, write and load scores correctly 
        scoring = new PrintWriter(new BufferedWriter(new FileWriter("/Users/HenryBallingerMcFarlane/Desktop/Game/scores.csv", true)));
        scoring.println(playerName + "," + score);
        scoring.flush();
        scoring.close();
      }
      catch (IOException e)
      {  
        println(e);
      }
      // Call function to calculate the top 5 highest scores of all time
      calculateHighScores();
    }
  }
} // End Key Pressed


void keyReleased()
{
  keys[keyCode] = false;
} // End Key Released


void mousePressed()
{
  if (overStart)
  {
    level = 2;
    introSound.stop();
    playSound(2);
  }
} // End Mouse Pressed


// Play the relevent sound depending on the ID passed to the function
void playSound(int soundID)
{
  if (mute != true)
  {
    switch (soundID)
    {
      // Intro
      case 1:
       introSound.play();
       break;
      // Countdown
      case 2:
       countdownSound.play();
       break;
      // Explosion
      case 3:
       explosionSound.play();
       break;
      // Thrust
      case 4:
       thrustSound.play();
       thrustSound.amp(0.08);
       break;
      // Laser
      case 5:
       laserSound.play();
       break;
      // Ship Destruction
      case 6:
        shipDestructionSound.play();
        break;
      // Alien Ship Destruction
      case 7:
        alienDestructionSound.play();
        break;
      // Powerup Collection
      case 8:
        powerupCollectionSound.play();
        break;
      // Powerup Activation
      case 9:
        powerupActivationSound.play();
        break;
      // Nuke Powerup
      case 10:
        nukeSound.play();
        break;
      // Forcefield Powerup
      case 11:
        forcefieldPowerupSound.play();
        break;
      // Freeze Powerup
      case 12:
        freezePowerupSound.play();
        break;
      // Game Win
      case 13:
        gameWinSound.play();
        break;
      // Game Over
      case 14:
        gameOverSound.play();
        break;
    }
  }
} // End Play Sound


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
} // End Draw Ship Lives


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
    // Rapid Fire
    case 5:
      fill(red);
      stroke(red);
      ellipse(0, -3, 3, 3);
      ellipse(0, 9, 3, 3);
      fill(yellow);
      stroke(yellow);
      ellipse(0, 3, 3, 3);
      ellipse(0, -9, 3, 3);
      break;
    // Extra Life
    case 6:
      stroke(aqua);
      line(0, -powerupLifeHeight, -powerupLifeWidth, powerupLifeHeight);
      line(0, -powerupLifeHeight, powerupLifeWidth, powerupLifeHeight);
      line(-powerupLifeWidth * 0.75f, powerupLifeHeight * 0.7f, powerupLifeWidth * 0.75f, powerupLifeHeight * 0.7f);
      break;
  }
} // End Draw Powerup Symbols


// Split asteroids into two smaller asteroids if big or medium, otherwise, if small, simply remove
// Only split asteroid into two if current number of asteroids on screen is less than 26 (simulating original game)
void splitAsteroid(int number)
{
  // Play asteoid destruction sound
  playSound(3);

  if (asteroids.get(number).radius == 90)
  {
    score += 5;
    for (int i = 0; i < 2; i++)
    {
      if (asteroids.size() < 27)
      {
        AsteroidObject asteroid = new Asteroid(asteroids.get(number).position.x, asteroids.get(number).position.y, 2);
        asteroids.add(asteroid);
      }
    }
  }
  else if (asteroids.get(number).radius == 60)
  {
    score += 10;
    for (int i = 0; i < 2; i++)
    {
      if (asteroids.size() < 27)
      {
        AsteroidObject asteroid = new Asteroid(asteroids.get(number).position.x, asteroids.get(number).position.y, 3);
        asteroids.add(asteroid);
      }
    }
  }
  else if (asteroids.get(number).radius == 30)
  {
    score += 15;
  }
  asteroids.remove(number);
} // End Split Asteroid

// Animation for rock debris upon destruction of asteroid or alien ship
void debris()
{
  for (int i = 0; i < asteroidDebrisPosition.size(); i++)
  {
    pushMatrix();    
    translate(asteroidDebrisPosition.get(i).x, asteroidDebrisPosition.get(i).y);
    stroke(200);
    rotate(TWO_PI * 0.2f * i);
    line(0, 0, 3, 0);
    line(3, 0, 5, 1);
    line(5, 1, 6, 2);
    line(6, 2, 1, 3);
    line(1, 3, 0, 0);
    asteroidDebrisPosition.get(i).add(asteroidDebrisMovement.get(i % 6));
    popMatrix();
  }

  // For every element of the times list (times the debris animation was initiated)
  // Check to see if the current timer value - element if evenly divisible by 50
  // That is, 5/6th of a second have passed since the animation was started
  // If so, remove those debris rocks from the arraylist of debris, thereby stopping the animation
  for (int j = 0; j < times.size(); j++)
  {
    if ((debrisTimer - times.get(j)) % 50 == 0)
    {
      for (int i = 5; i > -1; i--)
        asteroidDebrisPosition.remove(i);
      times.remove(j);
    }
  }
} // End Debris


// Nuclear explosion animation
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
} // End Nuke Explosion


// Player ship death animation
void shipDeath(float angle)
{ 
  // Kill the ship (stop rendering)
  shipDead = true;

  stroke(aqua);

  // Show ship explosion until timer has expired, at which point call reset function
  if (resetTimer < 50)
  {
    // Set all keys to false, so player cannot move ship
    for (int i = 0; i < keys.length; i++)
      keys[i] = false;

    // Line collapse - destruction of ship
    for (int i = 0; i < shipDebrisPositions.size(); i++)
    {
      PVector lPos = shipDebrisPositions.get(i).copy();
      pushMatrix();
      translate(lPos.x, lPos.y);     
      switch(i)
      {
      case 0:
        rotate(-angle/2);
        line(0, 0, 20, 20);
        break;
      case 1:
        rotate(angle);
        line(0, 0, 20, 20);
        break;
      case 2:
        rotate(PI);
        line(0, 0, 15, 15);
        break;
      case 3:
        line(0, 0, 10, 10);
        break;
      case 4:
        rotate(HALF_PI);
        line(0, 0, 20, 10);
        break;
      }
      popMatrix();  
      shipDebrisPositions.get(i).add(shipDebrisMovements.get(i));
      // Add a couple of extra lines in for added affect
      if (i > 2)
      {
        pushMatrix();
        translate(-lPos.x, -lPos.y);
        line(0, 0, 15, 10);
        popMatrix();
      }
    }
    resetTimer++;
  }
  else
  {
    resetShip();
  }
} // End Ship Death


void resetShip()
{
  // Reset ship debris position, so program knows to copy ship position into all ship debris position vectors 
  shipDebrisPositions.set(0, new PVector(0, 0));

  alienLasers.clear();
  reset = true;
  // Reset ship to be in center of screen
  asteroids.set(0, new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f));
  shipDead = false;

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

  // Reset any currently collected, on screen or activated powerups to be false
  for (int i = 0; i < noPowerUps; i++)
  {
    activated[i] = false;
    activeTimer = 0;
    onScreen[i] = false;
  }
  
  // Reset alien spaceship to be offscreen and awaiting entry time
  aliens.set(0, new AlienSpaceShip(int(random(1, 5))));
  enterAlien = false;
  alienTimer = 0;
} // End Reset Ship


void gameOver(boolean win)
{
  if (playAgain != true)
  {
    gameEnd = true;
    gameStart = false;
    // Add 25 points to score per life, set lives to be zero to prevent infinite multiplying
    score += lives * 25;
    lives = 0;
    textSize(40);
    // Display relevant win/lose message
    if (win)
    {
      playSound(13);
      fill(0, 255, 0);
      text("YOU WIN", width * 0.5f, height * 0.15f);
    }
    else
    {
      playSound(14);
      fill(red);
      text("GAME OVER", width * 0.5f, height * 0.15f);
    }
    fill(255);
    textSize(35);
    text("Your Score: " + score, width * 0.5f, height * 0.3f);
    textSize(30);
    // Get user to enter name, updating display on screen as they type
    text("Name: " + playerName, width * 0.5f, height * 0.45f);
    // Flashing typing line like in most word programs
    float tw = textWidth("Name: " + playerName) * 0.53f;
    if (typeTimer > 40)
    {
      line(width * 0.5f + tw, height * 0.42f, width * 0.5f + tw, height * 0.45f);
      if (typeTimer > 80)
        typeTimer = 0;
    }
    typeTimer++;
  }
} // End Game Over



void calculateHighScores()
{
  // Load table of all highscores from csv file
  scoreTable = loadTable("scores.csv", "header");
  for (TableRow row : scoreTable.rows())
  {
    players.append(row.getString("Name"));
    scores.append(row.getInt("Score"));
  }
  
  int[] scoresArray = scores.array();
  scores.sortReverse();

  // Go through top 5 elements of sorted scores list, finding them in the unsorted array of scores in order to find player names
  int display = scores.size();
  if (scores.size() > 5)
    display = 5;
  for (int s = 0; s < display; s++)
  {
    for (int a = 0; a < scoresArray.length; a++)
    {
      if (scores.get(s) == scoresArray[a])
        playerArray[s] = players.get(a);
    }
  }
  playAgain = true;
} // End Calculate High Scores


// Show list of 5 highest scores and give player option to start the game again
// If selected, everything is reset and game goes back to Start Game screen. If not, game exits.
void playAgain()
{
  textSize(40);
  text("HighScores", width * 0.5f, height * 0.1f);
  textSize(25);
  int display = scores.size();
  if (scores.size() > 5)
    display = playerArray.length;
  for (int i = 0; i < display; i++)
  {
    text(playerArray[i], width * 0.3f, height * 0.3f + (i * height * 0.06f));
    text(scores.get(i), width * 0.7f, height * 0.3f + (i * height * 0.06f));
  }
  textSize(35);
  fill(aqua);
  stroke(aqua);
  text("Player", width * 0.3f, height * 0.2f);
  text("Score", width * 0.7f, height * 0.2f);
  line(width * 0.2f, height * 0.22f, width * 0.4f, height * 0.22f);
  line(width * 0.6f, height * 0.22f, width * 0.8f, height * 0.22f);
  textSize(40);
  fill(255);
  text("Play Again?", width * 0.5f, height * 0.7f);

  float yesWidth = textWidth("Yes") * 0.5f;
  float noWidth = textWidth("No") * 0.5f;
  float yesTextSize = 35;
  float noTextSize = 35;
  cursor(CROSS);
  // Detect which option mouse is over, highlight that option
  if (mouseY > height * 0.7f && mouseY < height * 0.9f)
  {
    if (mouseX > width * 0.3f - yesWidth && mouseX < width * 0.3f + yesWidth)
    {
      cursor(HAND);
      yesTextSize = 45;
      // If they select to play again, setup asteroids and reset level
      if (mousePressed)
      {
        score = 0;
        level = 1;
        lives = 3;
        setupAsteroidObject();
        playAgain = false;
        gameEnd = false;
        gameStart = false;
        shipAlive = true;
        shipDead = false;
        countdown = 3;
        countdownTimer = 0;
        for (int i = 0; i < noPowerUps; i++)
        {
          activated[i] = false;
          activeTimer = 0;
          collected[i] = false;
          onScreen[i] = false;
        }
      }
    } else if (mouseX > width * 0.7f - noWidth && mouseX < width * 0.7f + noWidth)
    {
      cursor(HAND);
      noTextSize = 45;
      // Otherwise, exit the game
      if (mousePressed)
      {
        scoring.flush();
        scoring.close();
        exit();
      }
    } else
    {
      cursor(CROSS);
    }
  }
  textSize(yesTextSize);
  fill(0, 255, 0);
  text("Yes", width * 0.3f, height * 0.85f);
  textSize(noTextSize);
  fill(red);
  text("No", width * 0.7f, height * 0.85f);
} // End Play Again