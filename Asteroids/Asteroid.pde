class Asteroid extends AsteroidObject
{
  //float radius;
  
  Asteroid(float radius, float x, float y, int size)
  {
    super(x, y, size);
    this.radius = radius;
    asteroid = loadImage("asteroid.png");
    asteroid.resize((int)(radius * 1.3), (int)radius);
  }
  
  void update()
  {
    position.add(asteroidMove);
    if (position.x < 0)
     position.x = width;
    if (position.x > width)
     position.x = 0;
    if (position.y < 0)
     position.y = height;
    if (position.y > height)
     position.y = 0;
  }
  
  void render()
  {
    pushMatrix();
    translate(position.x - (radius * 0.65f), position.y - (radius * 0.5f));
    image(asteroid, 0, 0);
    popMatrix();
  }
}