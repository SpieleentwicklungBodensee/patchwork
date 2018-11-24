function render()
    lg.setColor(1, 1, 1)
    local bgWidth, bgHeight = getImageScaleForNewDimensions( Assets.mlpbg, 1024, 768 )
    local playerWidth, playerHeight = getImageScaleForNewDimensions(Assets.rainbowDash, 100, 100)
    local playerX, playerY = data.objects.player.body:getPosition()
  
    local emitterX, emitterY = psystem:getPosition()
    lg.draw(Assets.mlpbg, data.bgX, 0, 0, bgWidth, bgHeight)
    lg.draw(Assets.mlpbg, data.bgX+1024, 0, 0, bgWidth, bgHeight)
    lg.draw(psystem, 0, 0, 0, .05, .05)
    lg.draw(Assets.rainbowDash, playerX, playerY, 0, playerWidth, playerHeight, 175, 175)
    lg.setColor(1, 0, 0, .2)
  
    if data.debug then
      for i, o in pairs(data.objects) do 
        lg.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
      end
      for i, o in pairs(data.rockets) do 
        lg.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
      end
    end
    lg.setColor(1, 1,1)
  
    for i, o in pairs(data.enemies) do 
      lg.draw(Assets.elon, o.x, o.y)
    end
  
  
    for i,o in pairs(data.rockets) do
      local rocketX, rocketY = o.body:getPosition()
      lg.draw(Assets.bfr, rocketX, rocketY, o.body:getAngle(), .2, .2, 128*0.5, 378*0.5)
    end
  end

return {
    render = render
}