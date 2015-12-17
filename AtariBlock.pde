class AtariBlock extends PongObjects
{
  int row;
  
  AtariBlock(float startX, float startY, int row)
  {
    super(startX, startY);
    this.row = row;
  }
  
  void render(int ID)
  {
    pushMatrix();
    translate(block.x, block.y);
    rect(0, 0, width/(noOfBlocks/row), blockHeight);
    popMatrix();
  }
  
  void update()
  {
    // Do if ball hits, hide block here 
  }
}