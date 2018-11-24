require("globals")

function love.load()
  local callbacks = {"errhand", "update"}
  for k in pairs(love.handlers) do
      callbacks[#callbacks + 1] = k
  end

  Gamestate.registerEvents(callbacks)  
  Gamestate.switch(States.cloudsdale)
end

function love.update(dt)
  lurker.update()
end

function love.draw()
  lg.clear(0.1, 0.2, 0.3)
  Gamestate.current():draw()
end

function love.keypressed(key, unicode)
  if key == "escape" then love.event.quit() end
  if key == "r" then love.event.quit("restart") end
end
