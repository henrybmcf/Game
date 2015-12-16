class PongPaddle extends PongObjects
{
  int up;
  int down;
  float paddleHeight;

  PongPaddle(int up, int down, float startX, float startY, float paddleHeight)
  {
    super(startX, startY - (paddleHeight * 0.5f));
    this.paddleHeight = paddleHeight;
    this.up = up;
    this.down = down;
  }

  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rect(0, 0, 10, paddleHeight);
    popMatrix();
  }
  
  void update()
  {
    if (keys[up])
      if (pos.y >= 0)
        pos.sub(movePaddle);
        
    if (keys[down])
      if (pos.y + paddleHeight <= height)
        pos.add(movePaddle);
  }
}