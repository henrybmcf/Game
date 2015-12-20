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
    //line(0, 0, 0, 15);
    ellipse(0, 0, 2, 2);
    popMatrix();    
  }
  
  void update()
  {
    moveShip.x = sin(theta);
    moveShip.y = - cos(theta);  
    moveShip.mult(speed);
    position.add(moveShip);
    
    if (position.x < 0 || position.y < 0 || position.x > width || position.y > height)
      lasers.remove(this);
    
    for (int i = 1; i < asteroids.size(); i++)
    {
      if (position.x > asteroids.get(i).position.x - asteroids.get(i).radius * 0.4f &&
          position.x < asteroids.get(i).position.x + asteroids.get(i).radius * 0.4f &&
          position.y > asteroids.get(i).position.y - asteroids.get(i).radius * 0.45f &&
          position.y < asteroids.get(i).position.y + asteroids.get(i).radius * 0.45f)
      {
        explosionSound.play();
        asteroids.remove(i);
        lasers.remove(this);
      }
    }
  }
}