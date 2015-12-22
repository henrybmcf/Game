class Grid extends BattleObject
{
  Grid(float x, float y)
  {
    super(x, y);
    shot = false;
    grid = int(random(0, 5));
  }

  void render()
  {
    rect(gridPos.x, gridPos.y, gridSize, gridSize);
    //switch (grid)
    //{
    //  case 0:
    //    fill(0);
    //    break;
    //  case 1:
    //    fill(255);
    //    break;
    //  case 2:
    //    fill(0, 0, 255);
    //    break;
    //  case 3:
    //    fill(0, 255, 0);
    //    break;
    //  case 4:
    //    fill(255, 0, 0);
    //    break;
    //}
  }

  void update()
  {
    // If grid square is shot at
    if (shot)
    {
      switch (grid)
      {
        // If grid is empty, change to miss
        case 0:
         fill(255);
         break;
          
        // Grid is empty and shot at (miss by enemy)
        case 1:
          println("Please pick a grid square that hasn't been shot");
          break;
          
        // Grid is occupied by ship
        case 2:
          grid = 3;
          break;
          
        // Grid is occupied by ship & hit
        case 3:
          println("Please pick a grid square that hasn't been shot");
          break;
          
        // Grid is occupied by sunken ship
        case 4:
          println("Please pick a grid square that hasn't been shot");
          break;
      }
    }
    //if (shot)
    //  fill(255, 0, 0);
    //else
    //  fill(0);
  } 
}