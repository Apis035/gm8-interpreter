# Game Maker 8 Interpreter
Game Maker but running as interpreter

The legacy **Game Maker** (versions below **Game Maker: Studio**) has self-modifying code functions that allows it to dynamically change resources in the runtime. With this, it is possible to put all the game resources (including the game code and logic) outside of the `.exe` file and later load them into the game memory for fast resources accessing like if it was created using the Game Maker IDE.

This makes a possibility of creating game in Game Maker feels like creating game with real programming language where you put the game code in its own script file and load the resources by yourself rather than let the IDE do it all for you.

This repo is a proof of concept of how to utilize the self-modifying code functions. There are 2 example games included from the Game Maker 8 default tutorial. More will be added.

## 1945
Side scrolling shooter. Shoot or avoid enemies to survive. Your weapon will be upgraded after getting certain amount of scores.

Controls:
- Arrow keys: move
- Space: shoot

Simply open `gm8.exe` to play.

## Street Racing
Side scrolling arcade. Survive as long as possible, collect fuel to keep your engine running and avoid police chase.

Controls:
- Arrow keys: move

Open `street_racing.bat` to play.

# Create your own game
To create your own game, put the game script on a `.gml` file. By default, `gm8.exe` will load and run `\data\game.gml` file where you put the resource loading, game logic, and room creation code. You can also pass the script as command line parameter to indicate which script file the executable should load instead of `game.gml`.

Take a look on the example games `.gml` file to get the basic idea of how to load the game resources, creating objects, create object events, initializing rooms, etc. Also take a look at **Game Maker 8** documentation about changing resources which can be found [here](http://gamemaker.info/en/manual/409_00_changing) or from your Game Maker 8 program if you have it installed.
