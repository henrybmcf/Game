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

  void render()
  {
    pushMatrix();
    translate(ballPos.x, ballPos.y);
    ellipse(0, 0, diameter, diameter);
    popMatrix();
  }

  void update()
  {
    // Do the bouncing calculations here

    if (gameStart)
      ballPos.add(moveBall);
    
    // If ball is within x and y coordinates of paddle, bounce it back
    if (ballPos.x >= width * 0.925f - radius && ballPos.y > pPos.y && ballPos.y < pPos.y + paddleHeight)
      moveBall.x = -moveBall.x;
    
    if (ballPos.x < width * 0.01f + radius)
    {
      moveBall.x = -moveBall.x;
      score+=1;
    }

    if (ballPos.y > height - radius || ballPos.y < radius)
      moveBall.y = -moveBall.y;

    if (ballPos.x > width * 0.935f)
    {
      moveBall.x = abs(moveBall.x);
      Pong.remove(this); 
    }
  }
}