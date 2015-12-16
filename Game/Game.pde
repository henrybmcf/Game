/*
Object Orientated Programming Assignment 2 - Game
 Multi Level Game: Each level is a different game.
 */

void setup()
{
  size(600, 600);
  //fullScreen();
  textSize(45);

  level = 1;
  setupPong();
  ballStart = false;
  pPos = new PVector();

  time = 300;
  score = 0;
}

int level;
ArrayList<PongObjects> Pong = new ArrayList<PongObjects>();
boolean[] keys = new boolean[512];
boolean ballStart;
PVector pPos;

int time;
int score;

void setupPong()
{
  Pong.clear();
  PongObjects playerPaddle = new PongPaddle(UP, DOWN, width * 0.925f, height * 0.5f);
  Pong.add(playerPaddle);
  //PongPaddle AIPaddle = new PongPaddle(0, 0, width * 0.075f, height * 0.5f);
  //Pong.add(AIPaddle);
  //PongObjects ball = new PongBall(width * 0.5f, height * 0.5f, 20);
  //Pong.add(ball);
}

void draw()
{
  background(0);
  stroke(255);
  
  switch (level)
  {
  case 1:
    fill(255);
    stroke(255);
    text(score, width * 0.25f, height * 0.12f);
    
    // Timer for the second ball to enter
    if (ballStart)
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
    
    if (Pong.size() < 2)
    {
      ballStart = false;
      textAlign(CENTER);
      text("You Lose!!", width * 0.5f, height * 0.5f);
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
    ballStart = true;
    time = 0;
  }
}

void keyReleased()
{
  keys[keyCode] = false;
}