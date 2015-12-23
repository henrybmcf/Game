class Asteroid extends AsteroidObject
{ 
  float astRad;
  int size;
  
  // Three different image variables. One for each size
  
  // Resize each one dependent incoming size variable
  
  // Depending on that size variable, show that image
  //(float radius, 
  Asteroid(float x, float y, int size)
  {
    super(x, y, size);
    //super.radius = radius;
    larAsteroid = loadImage("asteroid.png");
    larAsteroid.resize((int)(largeAstRad * 1.3), (int)largeAstRad);
    medAsteroid = loadImage("asteroid.png");
    medAsteroid.resize((int)(medAstRad * 1.3), (int)medAstRad);
    smallAsteroid = loadImage("asteroid.png");
    smallAsteroid.resize((int)(smallAstRad * 1.3), (int)smallAstRad);
    //this.astRad = radius;
    radius = largeAstRad/size;
    this.size = size;
    println(radius);
  }
  
  void render()
  {
    pushMatrix();
    
    if (size == 1)
    {
      translate(position.x - (largeAstRad * 0.65f), position.y - (largeAstRad * 0.5f));
      image(larAsteroid, 0, 0);
    }
    else if (size == 2)
    {
      translate(position.x - (medAstRad * 0.65f), position.y - (medAstRad * 0.5f));
      image(medAsteroid, 0, 0);
    }
    else if (size == 3)
    {
      translate(position.x - (smallAstRad * 0.65f), position.y - (smallAstRad * 0.5f));
      image(smallAsteroid, 0, 0);
    }
    //line(0, -radius * 0.65f, -radius * 0.45f, -radius);    
    //line(-radius * 0.45f, -radius, -radius, -radius * 0.5f);    
    //line(-radius, -radius * 0.5f, -radius, radius * 0.5f);    
    //line(-radius, radius * 0.5f, -radius * 0.5f, radius);  
    //line(-radius * 0.5f, radius, radius * 0.3f, radius);   
    //line(radius * 0.3f, radius, radius, radius * 0.5f); 
    //line(radius, radius * 0.5f, radius * 0.75f, 0);   
    //line(radius * 0.75f, 0, radius, -radius * 0.5f); 
    //line(radius, -radius * 0.5f, radius * 0.5f, -radius); 
    //line(radius * 0.5f, -radius, 0, -radius * 0.65f);
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