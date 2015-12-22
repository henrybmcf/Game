void setup()
{
  size(600, 600);
  
  gameStart = true;
  
  gridNo = 10;
  gridSize = width / gridNo;

  setupGrid();
}

boolean gameStart;
ArrayList<BattleObject> battleships = new ArrayList<BattleObject>();
int gridNo;
int gridSize;

void setupGrid()
{
  battleships.clear();
  BattleObject square;

  for (int x = 0; x < gridNo; x++)
  {
    for (int y = 0; y < gridNo; y++)
    {
      square = new Grid(x * gridSize, y * gridSize);
      battleships.add(square);
    }
  }
}

void mousePressed()
{
  if (gameStart)
  {
    int x = mouseX / gridSize;
    int y = mouseY / gridSize;
    int num;
    if (x < 1)
      num = x + y;
    else
      num = x * 10 + y;
    
    battleships.get(num).shot =! battleships.get(num).shot;
    
    //switch (battleships.get(num).grid)
    //{
    //  case 0:
    //    battleships.get(num).grid = 1;
    //    break;
    //  case 1:
    //    println("Please pick a grid square that hasn't been shot");
    //    break;
       
    //  // Check to see if ship is then sunk
    //  case 2:
    //    battleships.get(num).grid = 3;
    //    break;
        
    //  case 3:
    //    println("Please pick a grid square that hasn't been shot");    //    break;
    //  case 4:
    //    println("Please pick a grid square that hasn't been shot");
    //    break;
    //}    
  }
}

void draw()
{
  background(0);
  stroke(255);
  fill(0);
  for (int i = 0; i < battleships.size(); i++)
  {
    battleships.get(i).update();
    battleships.get(i).render();
  }
}