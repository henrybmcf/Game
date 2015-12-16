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

  time = 0;
  score = 0;
}

int level;
int lives;
ArrayList<PongObjects> Pong = new ArrayList<PongObjects>();
boolean[] keys = new boolean[512];
boolean gameStart;
PVector pPos;

int time;
int score;

PongObjects playerPaddle;

void setupPong()
{
  Pong.clear();
  playerPaddle = new PongPaddle(UP, DOWN, width * 0.925f, height * 0.5f);
  Pong.add(playerPaddle);
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
        if (time % 300 == 0)
        {
          PongObjects ball = new PongBall(width * 0.5f, height * 0.5f, 20);
          Pong.add(ball);
          time++;
        }
        else
        {
          time++;
        }
      }
      println(lives);
      // If only object left is the paddle, all balls are offscreen, therefore, player loses a life
      // To ensure this message only occurs once the game has started, check to see if time is running, i.e. greater than the starting value of 0
      if (Pong.size() < 2 && time > 0)
      {
        gameStart = false;
        textAlign(CENTER);
        text("You Lose a Life!", width * 0.5f, height * 0.45f);
        if (lives == 1)
          text("Game Over", width * 0.5f, height * 0.55f);
        else
          lives--;
        time = 0;
      }

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
        pong.render();
        pong.update();
      }
      break;
  }
}

void keyPressed()
{
  keys[keyCode] = true;

  if (keyCode == ' ')
  {
    gameStart = true;
    //time = 0;
  }
}

void keyReleased()
{
  keys[keyCode] = false;
}