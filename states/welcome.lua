local scene = {}

-- load assets
function scene:init()
end

-- render your scene
function scene:draw()
  lg.print("Welcome! Press return to start the game.")
end

-- update your logic
function scene:update(dt)
end

-- handle input
function scene:keypressed(key, code)
  if key == "return" then
    Gamestate.switch(States.levelOne)
  end
end

return scene
