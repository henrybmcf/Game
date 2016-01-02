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
    // Move powerup across the screen
    pos.add(move);
    //render(ID);
    
    // If powerup moves offscreen, set the onScreen boolean to be false and set powerup entry timer to zero (i.e. start timing for next powerup to enter)
    if (pos.y > height)
    {
      onScreen[ID] = false;
      entryCountTimer = 0;
    }
  }
}
  