void setup()
{
   size(500, 500);
   
   // Pass random entry point here?
   spaceship = new Ship();
}

Ship spaceship;

void draw()
{
  background(0); 
  
  spaceship.render();
  spaceship.update();
}