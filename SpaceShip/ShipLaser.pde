class ShipLaser extends Master
{
  PVector laserMovement;
  float laserSpeed;
  
  ShipLaser(int ID)
  {
     //laserpos = position.copy();
     laserSpeed = 0.5;
     
     if (ID == 1 || ID == 3)
       laserMovement = new PVector(random(-2, 3), laserSpeed);
     else
       laserMovement = new PVector(random(-2, 3), -laserSpeed);
  }
  
  void render()
  {
     pushMatrix();
     translate(position.x, position.y);
     ellipse(0, 0, 2, 2);
     popMatrix();
  }
  
  void update()
  {
    position.add(laserMovement);
  }
  //void update()
  //{ 
  //  moveShip.x = sin(facingAngle);
  //  moveShip.y = - cos(facingAngle);  
  //  moveShip.mult(speed);
  //  position.add(moveShip);

  //}
}