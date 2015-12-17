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

  void render(int ID)
  {
    pushMatrix();
    if (ID == 1)
    {
      translate(paddlePos.x, paddlePos.y);
      rect(0, 0, 5, paddleHeight);
    } else if (ID == 2)
    {
      translate(blockPaddle.x, blockPaddle.y);
      rect(0, 0, paddleHeight, 5);
    }
    popMatrix();
  }

  void update(int ID)
  {
    if (ID != 3)
    {
      if (keys[up])
        if (paddlePos.y >= 0)
          paddlePos.sub(movePaddle);

      if (keys[down])
        if (paddlePos.y + paddleHeight <= height)
          paddlePos.add(movePaddle);
    }
    else if (ID == 3)
    {
      if (keys[up])
        if (blockPaddle.x + paddleHeight <= height)
          blockPaddle.add(moveBlockPad);
      if (keys[down])
        if (blockPaddle.x >= 0)
          blockPaddle.sub(moveBlockPad);
    }

    // Copy PVector position of paddle into PVector variable called pPos for use in PongBall sketch to determine if in range to bounce off or not
    // Copy into pPos if paddle belongs to player (1)
    // Copy into p2Pos if paddle belongs to player(2) or computer
    if (ID == 0)
      pPos = paddlePos;
    if (ID == 1)
      p2Pos = paddlePos;


    // Computer paddle (pending)
    //else
    //{
    //  cPos = paddlePos;
    //  if(gameStart)
    //  {
    //    if(bPos.y < cPos.y)
    //    {
    //      if (cPos.y >= 0)
    //      {
    //        cPos.sub(movePaddle);
    //      }
    //    }
    //    if(bPos.y > cPos.y + paddleHeight)
    //    {
    //      if (cPos.y + paddleHeight <= height)
    //      {
    //        cPos.add(movePaddle);
    //      }
    //    }
    //  }
    //}
  }
}