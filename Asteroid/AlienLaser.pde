class AlienLaser extends AlienObjects
{  
  AlienLaser(int pointID)
  {
    speed = random(3, 6);
    
    if (pointID == 1 || pointID == 3)
       movement = new PVector(random(-3, 3), speed);
    else
       movement = new PVector(random(-3, 3), -speed);
  }
  
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    ellipse(0, 0, 2, 2);
    popMatrix();    
  }
  
  void update()
  {
    position.add(movement);
    
    if (position.x < 0 || position.y < 0 || position.x > width || position.y > height)
      alienLasers.remove(this);
  }
}