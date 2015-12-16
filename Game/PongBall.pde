class PongBall extends PongObjects
{
  float radius;
  
  PongBall(float startX, float startY, float radius)
  {
    super(startX, startY);
    this.radius = radius;
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
  }
  
}