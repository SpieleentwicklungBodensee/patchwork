local scene = {}

-- load assets
function scene:init()
end

-- render your scene
function scene:draw()
  lg.print("Hello world")
end

-- update your logic
function scene:update(dt)
end

-- handle input
function scene:keypressed(key, code)
end

return scene
