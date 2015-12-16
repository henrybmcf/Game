class PongPaddle extends PongObjects
{
  int up;
  int down;

  PongPaddle(int up, int down, float startX, float startY)
  {
    super(startX, startY);
    this.up = up;
    this.down = down;
  }

  void render()
  {
    pushMatrix();
    translate(paddlePos.x, paddlePos.y);
    rect(0, 0, 5, paddleHeight);
    popMatrix();
  }

  void update()
  {
    if (keys[up])
      if (paddlePos.y >= 0)
        paddlePos.sub(movePaddle);

    if (keys[down])
      if (paddlePos.y + paddleHeight <= height)
        paddlePos.add(movePaddle);

    // Copy PVector position of paddle into PVector variable called pPos for use in PongBall sketch to determine if in range to bounce off or not
    pPos = paddlePos;
  }
}