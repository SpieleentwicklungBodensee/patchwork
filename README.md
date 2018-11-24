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
