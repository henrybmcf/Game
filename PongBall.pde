class PongBall extends PongObjects
{
  float diameter;
  float radius;

  PongBall(float startX, float startY, float diameter)
  {
    super(startX, startY);
    this.diameter = diameter;
    radius = diameter * 0.5f;
  }

  void render(int ID)
  {
    pushMatrix();
    translate(ballPos.x, ballPos.y);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
  }

  void update(int ID)
  {
    // Do the bouncing calculations here
    switch (level)
    {
    case 1:
      if (gameStart)
        ballPos.add(moveBall);
      // If ball is within x and y coordinates of paddle, bounce it back
      if (ballPos.x > width * 0.925f - radius && ballPos.y >= pPos.y && ballPos.y <= pPos.y + paddleHeight)
        moveBall.x = -moveBall.x; 
      else if (ballPos.x < width * 0.085f + radius && ballPos.y >= p2Pos.y && ballPos.y <= p2Pos.y + paddleHeight)
        moveBall.x = -moveBall.x;
      if (ballPos.y > height - radius || ballPos.y < radius)
        moveBall.y = -moveBall.y;
      if (ballPos.x > width * 0.935f)
      {
        Pong.remove(this);
        if(Pong.size() < 3)
          gameStart = false;
      } else if (ballPos.x < width * 0.075f)
      {
        Pong.remove(this);
        if(Pong.size() < 3)
          gameStart = false;
        score++;
        if (score == 5)
        {
          level = 2;
          setupPong();
        }
      }

      bPos = ballPos;
      break;
      
    case 2:
      if (gameStart)
        ballPos.add(moveBall);
      if (ballPos.x > width - radius || ballPos.x < radius)
        moveBall.x = -moveBall.x;
      
      //println(ballPos.x, pPos.x);
      println(ballPos.y, height * 0.925f - radius);
      if (ballPos.y < height * 0.925f - radius && ballPos.x >= pPos.x && ballPos.x <= pPos.x + paddleHeight)
        moveBall.y = -moveBall.y;

      //if (ballPos.x > width * 0.935f)
      //{
      // Pong.remove(this);
      // if(Pong.size() < 3)
      //   gameStart = false;
      //}
      break;
    }
  }
}