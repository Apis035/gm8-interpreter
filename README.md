# Game Maker 8 Interpreter
Game Maker but running as interpreter

The legacy Game Maker has self-modifying code ability that allows it to dynamically change resources in the runtime. This makes creating game in Game Maker feels like creating game with real programming language where you put the game code in its own script file and load the resources by yourself rather than let the IDE do it all for you.

To use, put the script on `\data\game.gml` path. The executable will load and run this file where you put the resource loading, game logic, and room creation code. You can also pass the script as command line parameter to load different script other than `game.gml`.

The current example in this project is 1945 game from the Game Maker tutorials. More will be added.
