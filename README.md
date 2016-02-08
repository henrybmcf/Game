# Game
Object Orientated Programming Christmas Assignment - Game

!! Note: In order to correctly write your name and score to the scores file, you must edit the path of the scores file to the full file path.
Please edit line _______  of the code appropriately to suit your computer. !!

The game that I chose to replicate was Asteroids.

Having chosen this game, I decided to replicate it to the best of my abilities, that being the mechanics of the game, the gameplay, etc., while still adding my own flair with a few upgrades.

The general aim of playing the game, to destroy the asteroids and alien spaceships and avoid crashing into them, remains the same in my version.
The main differences of my version of the game are the powerups. There are 7 power-ups in total.
First being the double shooter, this is a simple power-up. When normally shooting lasers, they come from the front of the ship and move in the direction the ship is facing when they are fired. With this powerup, an additional laser is fired from the rear of the ship, moving in the opposite direction to the normal laser.
Second is the quad shooter, this extends the idea of the double shooter, in that in addition to the two lasers from the front and rear, an additional two lasers are fired from the sides of the ship, one in either direction, perpendicular to the direction of those fired by the double shooter.
Third is the nuke. This is simple, when activated a nuclear bomb is dropped, with the radius increasing up to a certain point, any asteroids or alien ships within the blast radius are instantly vaporised.
Fourth is the forcefield. While this is activated, the player's ship is invincible, with all asteroids, alien ships and lasers that come into contact with it, being instantly destroyed.
Fifth is freeze. For the duration of this power-up, all asteroids are frozen in place. This does not however affect the alien ships, which are still free to move and shoot.
Sixth is rapid fire. This enables the player to fire up to 12 lasers per second compared to the normal 3.
Seventh is an extra life. This power-up is activated automatically upon collection.
All other power-ups are activated by their corresponding number keys.

Multiple power-ups can be activated simultaneously.

Controls:
The ship is controlled by the arrow keys, with the up arrow controlling forward motion and the left/right arrows controlling the direction the ship is facing.

Scoring System:
When destroyed, big asteroids are worth 5 points, medium worth 10 points and small worth 15.  Alien spaceships are worth 100 points each.
Upon completion of the game, every life you have remaining adds 25 points to your score.


For each level after level 2, that the player passes, they receive an extra life, up to a maximum of 5 lives.

Pause/Mute/Instructions
The game can be paused/un-paused by pressing the 'P' key at any point.
Mute can be activated/deactivated with the 'M' key.
The instruction screen can be shown/hidden with the 'I' key. This will also pause the game.

Upon loss of all lives or passing of all levels, a "You Win" or "Game Over" screen is displayed.
Also displayed is your score and an entry field to enter your name. Upon hitting enter, your name and score is saved in the scores file.
The next screen will display the top 5 highest scores of all time and an option to play again. If you select yes, the game resets and goes back to the start game screen, else the game exits.