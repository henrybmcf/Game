class PowerUp
{
  PVector pos;
  PVector move;
  float size;
  int ID;
  int laserSize;
  int lifeHeight;
  float lifeWidth;
  float theta;
  float sym;
  
  
  PowerUp(float startX, float startY)
  {
    pos = new PVector(startX, startY);
    
    if (startX > width * 0.5f)
      move = new PVector(-0.5, 0.75);
    else
      move = new PVector(0.5, 0.75);
    
    //size = 30;
    //laserSize = 3;
    //lifeHeight = 10;
    //lifeWidth = lifeHeight * 0.7f;
    //theta = TWO_PI / 6;
    //sym = size * 0.9f;
    
  }
  
  void render(int ID)
  {
    this.ID = ID;
    
    pushMatrix();
    translate(pos.x, pos.y);
    //fill(0);
    //stroke(aqua);
    //ellipse(0, 0, size, size);
    drawPowerupSymbols(ID);
    //switch (ID)
    //{
    //  // Double Shooter
    //  case 0:
    //    fill(red);
    //    stroke(red);
    //    ellipse(5, 0, laserSize, laserSize);
    //    fill(yellow);
    //    stroke(yellow);
    //    ellipse(-5, 0, laserSize, laserSize);
    //    break;
    //  // Quad Shooter
    //  case 1:
    //    fill(red);
    //    stroke(red);
    //    ellipse(-5, -5, laserSize, laserSize);
    //    ellipse(5, 5, laserSize, laserSize);
    //    fill(yellow);
    //    stroke(yellow);
    //    ellipse(5, -5, laserSize, laserSize);
    //    ellipse(-5, 5, laserSize, laserSize);
    //    break;
    //  // Nuke
    //  case 2:
    //    stroke(yellow);
    //    fill(yellow);
    //    arc(0, 0, sym, sym, theta, theta * 2.0f);
    //    arc(0, 0, sym, sym, PI, PI + theta);
    //    arc(0, 0, sym, sym, TWO_PI - theta, TWO_PI);
    //    stroke(0);
    //    ellipse(0, 0, size * 0.15f, size * 0.15f);
    //    break;
    //  // Forcefield
    //  case 3:
    //    ellipse(0, 0, powerupSymbol * 0.8f, powerupSymbol * 0.8f);
    //    ellipse(0, 0, powerupSymbol * 0.6f, powerupSymbol * 0.6f);
    //    ellipse(0, 0, powerupSymbol * 0.4f, powerupSymbol * 0.4f);
    //    break;
    //  // Extra Life
    //  case 4:
    //    stroke(aqua);
    //    line(0, -lifeHeight, -lifeWidth, lifeHeight);
    //    line(0, -lifeHeight, lifeWidth, lifeHeight);
    //    line(-lifeWidth * 0.75f, lifeHeight * 0.7f, lifeWidth * 0.75f, lifeHeight * 0.7f);
    //    break; 
    //}
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
  