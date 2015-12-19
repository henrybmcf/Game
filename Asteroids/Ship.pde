class Ship extends AsteroidObject
{
  int move;
  int left;
  int right;
  int fire;

  //Ship()
  //{
  //  super(width * 0.5f, height  * 0.5f, 0);
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
    forward.x = sin(theta);
    forward.y = - cos(theta);
    forward.mult(speed);
    
    if (keys[move])
    {
      position.add(forward);
    }      
    if (keys[left])
    {
      theta -= 0.1f;
    }
    if (keys[right])
    {
      theta += 0.1f;
    }      
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
    line(- 25, 25, 0, - 25);
    line(0, - 25, 25, 25);
    line(25, 25, 0, 0);
    line(- 25, 25, 0, 0);
    popMatrix();
  }   
}