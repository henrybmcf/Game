class PongBall extends PongObjects
{
  float radius;
  
  PongBall(float startX, float startY, float radius)
  {
    super(startX, startY);
    this.radius = radius;
    moveBall.x = 3;
    moveBall.y = 3;
  }

  void render()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }
  
  void update()
  {
    // Do the angle bouncing calculations here
    
    //sin(theta);
   //-cos(theta);
    //moveBall.mult(speed);
    
    println(moveBall);
    if (ballStart)
       pos.add(moveBall);
    
    if (pos.x > width * 0.925f && pos.y > mouseY - 70 && pos.y < mouseY + 70)
        moveBall.x = -moveBall.x;
    
    else if (pos.x < width * 0.075f)
    {
      moveBall.x = -moveBall.x;
    }
    
    if (pos.y > height || pos.y < 0)
    {
      println("Y");
       moveBall.y = -moveBall.y;
    }
    
    //println(theta);
    //if (pos.x > width * 0.925f || pos.x < width * 0.075f)
    //{
    //  if (theta > PI + HALF_PI)
    //  {
    //    theta -= HALF_PI;
    //  }
    //}
    //if (pos.y > height || pos.y < 0)
    //{
    //  theta += PI/6;
    //}
  }
  
}