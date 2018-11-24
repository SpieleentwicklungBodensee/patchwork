# Patchwork Game

# Prerequisites

- [Love2D](https://love2d.org/)

# Develop
```
git clone git@github.com:SpieleentwicklungBodensee/patchwork.git
cd patchwork
git submodule init
git submodule update
love .
```

# Add level
* Copy states/example.lua to states/yourLevelName.lua
* Add `yourLevelName = require("states/yourLevelName.lua"),` to states/states/lua

# How to transit to another level
Call `Gamestate.switch(yourLevelName)`

# How to load assets
Put your images, sounds and levels in the assets folder. All files are loaded automatically and are available under the variable `Assets.*`.

# Dependencies
* [Cargo](https://github.com/bjornbytes/cargo) asset loader
* [Hump](https://hump.readthedocs.io/en/latest/) helper utilities
