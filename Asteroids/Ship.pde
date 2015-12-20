class Ship extends AsteroidObject
{
  int move;
  int left;
  int right;
  int fire;

  //Ship()
  //{
  // super(width * 0.5f, height  * 0.5f, 0);
  //}
  
  Ship(int move, int left, int right, int fire, float startX, float startY)
  {
    super(startX, startY, 0);
    this.move = move;
    this.left = left;
    this.right = right;
    this.fire = fire;
  }

  int elapsed = 12;
  
  void update()
  {
    moveShip.x = sin(theta);
    moveShip.y = - cos(theta);
    moveShip.mult(speed);
    
    if (keys[move])
      position.add(moveShip);
    if (keys[left])
      theta -= 0.1f;
    if (keys[right])
      theta += 0.1f;
     
    //if (keys[fire] && elapsed > 12)
    //{
    //  Bullet bullet = new Bullet();
    //  bullet.pos.x = pos.x;
    //  bullet.pos.y = pos.y;
    //  bullet.pos.add(PVector.mult(forward, 6));
    //  bullet.c = c;
    //  bullet.theta = theta;
    //  gObjects.add(bullet);     
    //  elapsed = 0;
    //}
    
    if (position.x < 0)
     position.x = width;
    if (position.x > width)
     position.x = 0;
    if (position.y < 0)
     position.y = height;
    if (position.y > height)
     position.y = 0; 
    
    elapsed ++;
  }
  
  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    line(0, -shipSize, -halfShip, shipSize);
    line(0, -shipSize, halfShip, shipSize);
    line(-halfShip * 0.75f, shipSize * 0.75f, halfShip * 0.75f, shipSize * 0.75f);   
    popMatrix();
  }   
}