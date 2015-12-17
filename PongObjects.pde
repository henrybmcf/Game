class PongObjects
{
  float paddleHeight;
  PVector paddlePos;
  PVector ballPos;
  float speed;
  PVector movePaddle;
  PVector moveBall;
  float ballSpeed;
  PVector moveBlockPad;
  PVector blockPaddle;
  PVector block;
  
  PongObjects()
  {
    this(width * 0.925f, height * 0.5f); 
  }

  PongObjects(float startX, float startY)
  {
    paddleHeight = 140;
    paddlePos = new PVector(startX, startY - (paddleHeight * 0.5f));
    ballPos = new PVector(startX, startY);
    speed = 10;
    movePaddle = new PVector(0, speed);
    ballSpeed = 5;
    moveBall = new PVector(ballSpeed, ballSpeed);
    
    moveBlockPad = new PVector(speed, 0);
    blockPaddle = new PVector(startX - (paddleHeight * 0.5f), startY);
    block = new PVector(startX, startY);  
  }
  
  void render(int ID)
  {
  }

  void update(int ID)
  {
  }
}