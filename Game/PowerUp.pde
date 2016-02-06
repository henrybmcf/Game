class PowerUp
{
  PVector pos;
  PVector move;
  int ID;
   
  PowerUp(float startX, float startY)
  {
    pos = new PVector(startX, startY);
    
    if (startX > width * 0.5f)
      move = new PVector(-0.5, 0.75);
    else
      move = new PVector(0.5, 0.75);    
  }
  
  void render(int ID)
  {
    this.ID = ID;
    
    pushMatrix();
    translate(pos.x, pos.y);
    drawPowerupSymbols(ID);
    popMatrix();
  }
  
  void update()
  {
    // Move powerup across the screen
    pos.add(move);
    
    // If powerup moves offscreen, set the onScreen boolean to be false and set powerup entry timer to zero (i.e. start timing for next powerup to enter)
    if (pos.y > height)
    {
      onScreen[ID] = false;
      entryCountTimer = 0;
      power = new PowerUp(random(width), -20);
    }
  }
}
  