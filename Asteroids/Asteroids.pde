void setup()
{
  size(600, 600);
  
  setupAsteroids();
  
  noAsteroids[0] = 10;
  noAsteroids[1] = 15;
  noAsteroids[2] = 20;
}

ArrayList<Asteroids> asteroids = new ArrayList<Asteroids>();

Integer[] noAsteroids = new Integer[3];

void setupAsteroids()
{
  asteroids.clear();
  
  Asteroid ship = new Ship(UP, LEFT, RIGHT, ' ', width * 0.5f, height * 0.5f);
  asteroids.add(ship);
  
  for(int i = 0; i < 
}

void draw()
{
  
}