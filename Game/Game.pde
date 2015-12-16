/*
Object Orientated Programming Assignment 2 - Game
 Multi Level Game: Each level is a different game.
 */

void setup()
{
  size(800, 600);
  background(0);

  level = 1;
  setupPong();
}

int level;
ArrayList<PongObjects> Pong = new ArrayList<PongObjects>();
boolean[] keys = new boolean[512];

void setupPong()
{
  Pong.clear();
  PongObjects playerPaddle = new PongPaddle(UP, DOWN, width - 70, height * 0.5f, 140);
  Pong.add(playerPaddle);
  PongPaddle AIPaddle = new PongPaddle(0, 0, 70, height * 0.5f, 140);
  Pong.add(AIPaddle);
  PongObjects ball = new PongBall(width * 0.5f, height * 0.5f, 20);
  Pong.add(ball);
}

void draw()
{
  background(0);
  stroke(255);
  
  switch (level)
  {
    case 1:
      // Let's draw the centre dividing line
      for (int i = 5; i < height; i += 20)
        line(width * 0.5f, i, width * 0.5f, i + 10);
      // Calling all the objects within PongObjects, that is the paddles and the ball(s)
      for (int i = Pong.size() - 1; i >= 0; i--)
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
}

void keyReleased()
{
  keys[keyCode] = false;
}