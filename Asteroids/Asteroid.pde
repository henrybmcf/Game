class Asteroid extends AsteroidObject
{
  float radius;
  
  Asteroid(float radius, float x, float y, int size)
  {
    super(x, y, size);
    this.radius = radius;
  }
  
  void update()
  {
    //position.add(asteroidMove);
    //if (position.x < 0)
    //  position.x = width;
    //if (position.x > width)
    //  position.x = 0;
    //if (position.y < 0)
    //  position.y = height;
    //if (position.y > height)
    //  position.y = 0;
  }
  
  void render()
  {
    //pushMatrix();
    //translate(position.x, position.y);
    //ellipse(0, 0, radius, radius);
    //popMatrix();
  }
}