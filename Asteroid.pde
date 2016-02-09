class Asteroid extends AsteroidObject
{ 
  // Image variables for the asteroid images
  PImage larAsteroid;
  PImage medAsteroid;
  PImage smallAsteroid;
  float astRad;
  int size;

  // Three different image variables. One for each size
  // Resize each one dependent incoming size variable
  Asteroid(float x, float y, int size)
  {
    super(x, y, size);
    larAsteroid = loadImage("asteroid.png");
    medAsteroid = loadImage("asteroid.png");
    smallAsteroid = loadImage("asteroid.png");
    larAsteroid.resize(largeAstRad, largeAstRad);
    medAsteroid.resize(medAstRad, medAstRad); 
    smallAsteroid.resize(smallAstRad, smallAstRad);
    
    if (size == 2)
      radius = largeAstRad / (size * 0.75f);
    else
      radius = largeAstRad / size;
    this.size = size;
  }
  
  // Depending on size variable, show that image
  void render()
  {
    pushMatrix();
    switch (size)
    {
      case 1:
        translate(position.x - (largeAstRad * 0.5f), position.y - (largeAstRad * 0.5f)); 
        image(larAsteroid, 0, 0);
        break;
      case 2:
        translate(position.x - (medAstRad * 0.5f), position.y - (medAstRad * 0.5f));
        image(medAsteroid, 0, 0);
        break;
      case 3:
        translate(position.x - (smallAstRad * 0.5f), position.y - (smallAstRad * 0.5f));
        image(smallAsteroid, 0, 0);
        break;
    }
    popMatrix();
  }

  void update()
  {
    position.add(asteroidMove);

    // Loop back around if off screen
    if (position.x + radius < 0)
      position.x = width + radius/3;
    if (position.x - radius > width)
      position.x = 0 - radius/3;
    if (position.y + radius < 0)
      position.y = height + radius/3;
    if (position.y - radius > height)
      position.y = 0 - radius/3;
  }
}