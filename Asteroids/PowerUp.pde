class PowerUp extends AsteroidObject
{
  PVector pos;
  PVector move;
  float size;
  int ID;
  
  PowerUp(float startX, float startY)
  {
    pos = new PVector(startX, startY);
    move = new PVector(0.5, 0.75);
    
    size = 30;
  }
  
  void render(int ID)
  {
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, size, size);
    popMatrix();
    this.ID = ID;
  }
  
  void update()
  {
    pos.add(move);
    render(ID);
    
    if (pos.y > height)
      enterPowerUp = false;
  }
}
  