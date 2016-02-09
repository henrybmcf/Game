#Asteroids Game Replica
##Object Orientated Programming Christmas Assignment - Game


####!! Note: In order to correctly write your name and score to the scores file, you must edit the path of the scores file to the full file path. Please edit line 643 of the code appropriately to suit your computer. !!

Having chosen this game, I decided to replicate it to the best of my abilities, that being the mechanics of the game, the gameplay, etc., while still adding my own flair with a few upgrades.

The general aim of playing asteroids, to destroy the asteroids & alien spaceships, avoid crashing and reach as high a score as possible, remains the same in my version.
One of the main differences of my version of the game are the powerups. There are 7 power-ups in total.

###Power-ups:
1. Double shooter, this is a simple power-up. When normally shooting lasers, they come from the front of the ship and move in the direction the ship is facing when they are fired. With this powerup, an additional laser is fired from the rear of the ship, moving in the opposite direction to the normal laser.
2. Quad shooter, this extends the idea of the double shooter, in that in addition to the two lasers from the front and rear, an additional two lasers are fired from the sides of the ship, one in either direction, perpendicular to the direction of those fired by the double shooter.
3. Nuke. This is simple, when activated a nuclear bomb is dropped, with the radius increasing up to a certain point, any asteroids or alien ships within the blast radius are instantly vaporised.
4. Forcefield. While this is activated, the player's ship is invincible, with all asteroids, alien ships and lasers that come into contact with it, being instantly destroyed.
5. Freeze. For the duration of this power-up, all asteroids are frozen in place. This does not however affect the alien ships, which are still free to move and shoot.
6. Rapid fire. This enables the player to fire up to 12 lasers per second compared to the normal 3.
7. Extra life. This power-up is activated automatically upon collection (Maximum 5 lives). For each level after level 2, that the player passes, they also receive an extra life.
- All other power-ups are activated by their corresponding number keys.
- Multiple power-ups can be activated simultaneously.

###Controls:
The ship is controlled by the arrow keys.
- Up arrow controls forward motion
- Left/right arrows control the direction the ship is facing.

- Start game by clicking 'Start Game' or by pressing Space Key.
- The game can be paused/un-paused by pressing the 'P' key at any point.
- Mute can be activated/deactivated with the 'M' key.
- The instruction screen can be shown/hidden with the 'I' key. This will also pause the game.
- Enter name for score by typing
- Select Play Again option by clicking

###Scoring System:
- Big Asteroids = 5 points
- Medium Asteroids = 10 points
- Small Asteroids = 15 points
- Alien spaceship = 100 points
- Upon game end, every remaining life = 25 points

###Game Completion:
- Upon loss of all lives or passing of all levels, a "You Win" or "Game Over" screen is displayed.
- Also displayed is your score and an entry field to enter your name. Upon hitting enter, your name and score is saved in the scores file.
- The next screen will display the top 5 highest scores of all time and an option to play again. If you select yes, the game resets and goes back to the start game screen, else the game exits.