import processing.sound.*;
import java.io.FileWriter;
import java.io.BufferedWriter;

void setup()
{
  //size(700, 600);
  fullScreen();
  smooth(8);
  strokeWeight(1.5);
  cursor(CROSS);
  
  // Load the intro soundtrack and start playing
  //intro = new SoundFile(this, "introMusic.wav");
  //intro.rate(0.4);
  playSound(1);
  //countdownSound = new SoundFile(this, "countdown.mp3");
  //laserSound = new SoundFile(this, "shoot.wav");
  //thrustSound = new SoundFile(this, "thrust.wav");
  //explosionSound = new SoundFile(this, "expLarge.wav");
  //nukeSound = new SoundFile(this, "nuke.wav");
  
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
  lives = 0;
  livesHitCounter = 0;
  shipAlive = true;
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
  entryTime = int(random(300, 420));
  entryCountTimer = 0; 
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
SoundFile intro;
SoundFile countdownSound;
SoundFile laserSound;
SoundFile thrustSound;
SoundFile explosionSound;
SoundFile nukeSound;

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
// Boolean to determine if ship is dead or alive
boolean shipAlive;
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
// Time to enter onto screen
int entryTime;
// Timer to time entry onto screen
int entryCountTimer;
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
  background(0);
  stroke(255);
  textAlign(CENTER);
  if (level == 1)
  {
    asteroids.get(0).render();
    fill(255);
    textSize(80);
    text("ASTEROIDS", width * 0.5f, height * 0.3f);
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
      //countdownSound.stop();
      shipAlive = true;
      gameStart = true;
    }
    
    // If instruction screen is showing, stop timer controlling countdown to effectively pause the countdown
    if (gameStart != true && showInstruction == false)
      countdownTimer++;

    // Ship is the first element in list, therefore always render and update
    if (pause == false)
      asteroids.get(0).update();
    if (gameEnd == false)
      asteroids.get(0).render();

    if (asteroids.size() > 1)
    {
      if (gameEnd == false)
      {
        for (int i = 1; i < asteroids.size(); i++)
        {
          asteroids.get(i).render();
          // Only update (move) asteroids if the game has started
          if (gameStart && activated[4] == false)
            asteroids.get(i).update();
        }
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
    } else
    {
      gameStart = false;
      // Set all keys to false, so player cannot move ship
      for (int i = 0; i < keys.length; i++)
        keys[i] = false;
      if (level < levels)
      {
        level++;
        // Player gets an extra life for each level they pass after level 2
        if (level > 2 && lives < 10)
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
      } else if (showHighScores != true)
      {
        gameOver(true);
      }
    }
  }

  // Powerup timing, collection and activations
  if (gameStart && gameEnd == false)
  {
    // Increment entry timer to know when to enter onto screen
    entryCountTimer++;    
    // Once timer has reached time to enter, enter powerup onto screen
    if (entryCountTimer == entryTime)
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

  // Draw the collected powerup symbols in the top right corner
  for (int i = 0; i < noPowerUps; i++)
  {
    if (onScreen[i])
    {
      // Call class to show powerup and move across screen (if game is running)
      if (gameEnd != true)
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
  if (level > 1 && gameEnd == false)
    text("Level " + (level - 1), width * 0.5f, height * 0.065f);

  // Show user their current score
  text(score, width * 0.95f, height * 0.95f);

  // Show play again menu
  if (playAgain)
    playAgain();
    
  if (showInstruction)
    instructions.render();
} // End Draw

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
      fill(0, 255, 0);
      text("YOU WIN", width * 0.5f, height * 0.15f);
    } else
    {
      fill(red);
      text("GAME OVER", width * 0.5f, height * 0.15f);
    }
    fill(255);
    textSize(35);
    text("Your Score: " + score, width * 0.5f, height * 0.3f);
    textSize(30);
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
  scoreTable = loadTable("/Users/HenryBallingerMcFarlane/Desktop/Game/Asteroids/scores.csv", "header");
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

void playAgain()
{
  // Display list of 5 highest scores
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
        playAgain = false;
        gameEnd = false;
        score = 0;
        level = 1;
        lives = 5;
        setupAsteroidObject();
      }
    }
    else if (mouseX > width * 0.7f - noWidth && mouseX < width * 0.7f + noWidth)
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
    }
  }
  cursor(CROSS);
  textSize(yesTextSize);
  fill(0, 255, 0);
  text("Yes", width * 0.3f, height * 0.85f);
  textSize(noTextSize);
  fill(red);
  text("No", width * 0.7f, height * 0.85f);
} // End Play Again

void keyPressed()
{
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
        scoring = new PrintWriter(new BufferedWriter(new FileWriter("/Users/HenryBallingerMcFarlane/Desktop/Game/Asteroids/scores.csv", true)));
        scoring.println(playerName + "," + score);
        scoring.flush();
        scoring.close();
      }
      catch (IOException e)
      {  
        println(e);
      }
      //showHighScores = true;
      calculateHighScores();
    }
  }

  // Press space bar to start game on intro screen
  if (keyCode == ' ' && level == 1)
  {
    level = 2;
    //intro.stop();
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
  if (keyCode == 'M')
  {
    mute =! mute;
    if (mute)
    {
      //intro.stop();
      //countdownSound.stop();
      //explosionSound.stop();
      //thrustSound.stop();
      //laserSound.stop();
      //nukeSound.stop();
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
  
  if (keyCode == 'I')
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
} // End Key Pressed

void keyReleased()
{
  keys[keyCode] = false;
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

void setupAsteroidObject()
{
  lasers.clear();
  asteroids.clear();
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

void mousePressed()
{
  if (overStart)
  {
    level = 2;
    //intro.stop();
    playSound(2);
  }
} // End Mouse Pressed

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
  } else
  {
    resetShip();
  }
} // End Ship Death

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
} // End Ship Death

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

void splitAsteroid(int number)
{
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
  } else if (asteroids.get(number).radius == 60)
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
  } else if (asteroids.get(number).radius == 30)
  {
    score += 15;
  }
  asteroids.remove(number);
} // End Split Asteroid

void playSound(int ID)
{
  if (mute != true)
  {
    switch (ID)
    {
      // Intro
      //case 1:
      //  intro.play();
      //  break;
      //  // Countdown
      //case 2:
      //  countdownSound.play();
      //  break;
      //  // Explosion
      //case 3:
      //  explosionSound.play();
      //  break;
      //  // Thrust
      //case 4:
      //  thrustSound.play();
      //  thrustSound.amp(0.08);
      //  break;
      //  // Laser
      //case 5:
      //  laserSound.play();
      //  break;
      //  // Nuke
      //case 6:
      //  nukeSound.play();
      //  break;
    }
  }
} // End Play Sounds