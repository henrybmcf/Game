/*
Object Orientated Programming Assignment 2 - Game
 Multi Level Game: Each level is a different game.
 */


/*

 Notes to self:
 
 Fix you lose a life bug: shows, then hides quickly 
 
 */



void setup()
{
  size(600, 600);
  //fullScreen();
  textSize(45);

  level = 1;
  lives = 2; 
  setupPong();
  gameStart = false;
  pPos = new PVector();
  p2Pos = new PVector();
  bPos = new PVector();
  
  ballDiam = 20;
  time = 0;
  score = 0;

  noOfBlocks = 20;
  blockHeight = 50;
}

int level;
int lives;
ArrayList<PongObjects> Pong = new ArrayList<PongObjects>();
boolean[] keys = new boolean[512];
boolean gameStart;

PVector pPos;
PVector p2Pos;
PVector bPos;

int ballDiam;

int time;
int score;

PongObjects playerPaddle;
PongObjects player2Paddle;
PongObjects computerPaddle;

PongObjects atariblocks;

int noOfBlocks;
float blockHeight;

void setupPong()
{
  println(level);
  if (level == 1)
  {
    Pong.clear();
    playerPaddle = new PongPaddle(UP, DOWN, width * 0.925f, height * 0.5f);
    Pong.add(playerPaddle);
    player2Paddle = new PongPaddle('W', 'S', width * 0.075f, height * 0.5f);
    Pong.add(player2Paddle);
    //computerPaddle = new PongPaddle(0, 0, width * 0.075f, height * 0.5f);
    //Pong.add(computerPaddle);
  }
  else if (level == 2)
  {
    Pong.clear();
    playerPaddle = new PongPaddle(RIGHT, LEFT, width * 0.5f, height * 0.9f);
    Pong.add(playerPaddle);

    for (int i = 4; i > 0; i--)
    {
      for (int j = 0; j < noOfBlocks/i; j++)
      {
        atariblocks = new AtariBlock(j * (width / (noOfBlocks/i)), (i - 1) * blockHeight, i);
        Pong.add(atariblocks);
      }
    }
  }
}

void draw()
{
  background(0);
  stroke(255);

  // Load each level
  switch (level)
  {
  case 1:
    fill(255);
    stroke(255);
    text(score, width * 0.25f, height * 0.12f);

    // Timer for the more balls to enter
    // If game is running, wait 5 seconds between inserting new ball
    if (gameStart)
    {
      if (time % 600 == 0)
      {
        PongObjects ball = new PongBall(width * 0.5f, height * 0.5f, ballDiam);
        Pong.add(ball);
        time++;
      } else
      {
        time++;
      }
    }

    // If only object left is the paddle, all balls are offscreen, therefore, player loses a life
    // To ensure this message only occurs once the game has started, check to see if time is running, i.e. greater than the starting value of 0
    //if (Pong.size() < 2 && time > 0)
    //{
    //  gameStart = false;
    //  textAlign(CENTER);
    //  text("You Lose a Life!", width * 0.5f, height * 0.45f);
    //  if (lives == 1)
    //    text("Game Over", width * 0.5f, height * 0.55f);
    //  else
    //    lives--;
    //  time = 0;
    //}

    // Let's draw the centre dividing line
    for (int i = 5; i < height; i += 20)
      line(width * 0.5f, i, width * 0.5f, i + 10);

    fill(0, 120, 255);
    stroke(0, 120, 255);
    rect(0, 0, width * 0.02f, height);
    // Calling all the objects within PongObjects, that is the paddles and the ball(s)
    for (int i = 0; i < Pong.size(); i++)
    {
      PongObjects pong = Pong.get(i);
      pong.render(1);
      pong.update(i);
    }
    break;

  case 2:
    if (gameStart)
    {
      // To enure only one ball gets added, check to see if time is 0 (it will when space key is pressed, i.e. game is started)
      if (time == 0)
      {
        PongObjects ball = new PongBall(width * 0.5f, height * 0.5f, ballDiam);
        Pong.add(ball);
        time += 1;
      }
    }
    for (int i = 0; i < Pong.size(); i++)
    {
      PongObjects pong = Pong.get(i);
      pong.render(2);
      pong.update(3);
    }
    break;
  }
}

void keyPressed()
{
  keys[keyCode] = true;

  if (keyCode == ' ')
  {
    if(gameStart != true)
    {
      gameStart = true;
      time = 0;
    }
  }

  if (key >= '1' && key <= '2')
  {
    level = key - '0';
    setupPong();
    gameStart = false;
  }
}

void keyReleased()
{
  keys[keyCode] = false;
}