class PongObjects
{
  float paddleHeight;
  PVector paddlePos;
  PVector ballPos;
  float speed;
  PVector movePaddle;
  PVector moveBall;
  float ballSpeed;
  
  PongObjects()
  {
    this(width * 0.925f, height * 0.5f); 
  }

  PongObjects(float startX, float startY)
  {
    paddleHeight = 140;
    paddlePos = new PVector(startX, startY - (paddleHeight * 0.5f));
    ballPos = new PVector(startX, startY);
    speed = 6;
    movePaddle = new PVector(0, speed);
    ballSpeed = 5;
    moveBall = new PVector(ballSpeed, ballSpeed);
  }
  
  void render()
  {
  }

  void update()
  {
  }
}