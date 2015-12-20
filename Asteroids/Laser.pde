class Laser extends AsteroidObject
{  
  Laser()
  {
    speed = 10.0f;
  }
  
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    line(0, 0, 0, 15);
    popMatrix();    
  }
  
  void update()
  {
    moveShip.x = sin(theta);
    moveShip.y = - cos(theta);
      
    moveShip.mult(speed);
    position.add(moveShip);
    
    if (position.x < 0 || position.y < 0 || position.x > width || position.y > height)
    {
      asteroids.remove(this);
    }
  }
}