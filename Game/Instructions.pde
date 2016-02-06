class Instructions
{   
  void render()
  {
    fill(0);
    stroke(0);
    // Cover the screen with a black rectangle to hide all objects
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(50);
    text("INSTRUCTIONS", width * 0.5f, height * 0.1f);
    textSize(25);    
    // Instructions explaining controls, powerups and scoring systems
    text("Movement controls\n" + 
          "Move: Up Arrow    Turning: Right/Left Arrows    " +
          "Space: Shoot\n" + " \n" +
          "7 powerups in the game. Numbers = activation keys:\n" + 
          "1 - Double Shooter    2 - Quad Shooter    3 - Nuke    4 - Forcefield\n" + 
          "5 - Freeze    6 - Rapid Fire    Extra Life (Auto activation)\n" + " \n" + 
          "After level receive extra life for each level passed.\n10 levels in total\n" + " \n" +
          "Points System:\n" + 
          "Big Asteroid: 5    Medium Asteroid: 10    Small Asteroid: 15\nSpaceship: 100    End of game: Each life = 25",
          width * 0.05f, height * 0.2f, width * 0.9f, height * 0.7f);
  }
}