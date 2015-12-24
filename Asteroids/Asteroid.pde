class Asteroid extends AsteroidObject
{ 
  float astRad;
  int size;
  
  // Three different image variables. One for each size
  
  // Resize each one dependent incoming size variable
  
  // Depending on that size variable, show that image
  
  Asteroid(float x, float y, int size)
  {
    super(x, y, size);
    //super.radius = radius;
    larAsteroid = loadImage("asteroid.png");
    larAsteroid.resize(largeAstRad, largeAstRad);
    medAsteroid = loadImage("asteroid.png");
    medAsteroid.resize(medAstRad, medAstRad);
    smallAsteroid = loadImage("asteroid.png");
    smallAsteroid.resize(smallAstRad, smallAstRad);
    radius = largeAstRad/size;
    this.size = size;
  }
  
  void render()
  {
    pushMatrix();
    translate(position.x - ((largeAstRad / size) * 0.5f), position.y - ((largeAstRad / size) * 0.5f));
    if (size == 1)
      image(larAsteroid, 0, 0);
    else if (size == 2)
      image(medAsteroid, 0, 0);
    else if (size == 3)
      image(smallAsteroid, 0, 0);
    popMatrix();
  }
  
  void update()
  {
    position.add(asteroidMove);
    
    // Loop back around if off screen
    if (position.x < 0)
     position.x = width;
    if (position.x > width)
     position.x = 0;
    if (position.y < 0)
     position.y = height;
    if (position.y > height)
     position.y = 0;
  }
}