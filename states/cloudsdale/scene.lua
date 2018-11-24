local scene = {}
local data = require("states/cloudsdale/variables")

function addEnemy()
  local enemy = {}

  enemy.body = love.physics.newBody(world, 800, 768-150)
  enemy.shape = love.physics.newRectangleShape(130, 300)
  enemy.maxHp = 10000000
  enemy.hp = enemy.maxHp
  enemy.hpBarWidth = 100
  enemy.hitTime = 0
  enemy.fixture = love.physics.newFixture(enemy.body, enemy.shape)
  enemy.fixture:setUserData("enemy")
  table.insert(data.enemies, enemy)
end

function shoot(posX, posY)
  local rocket = {}
  rocket.power = 100000
  rocket.body = love.physics.newBody(world, posX, posY, "dynamic")
  rocket.shape = love.physics.newRectangleShape(128, 378)
  rocket.fixture = love.physics.newFixture(rocket.body, rocket.shape, 5)
  rocket.fixture:setUserData("rocket")
  rocket.body:setAngle(math.rad(90))
  rocket.body:setLinearVelocity(3000, -50)
  
  table.insert(data.rockets, rocket)
end

function beginContact(a, b, coll)
  if (a:getUserData() == "rocket" and b:getUserData() == "enemy") or (a:getUserData() == "enemy" and b:getUserData() == "rocket") then
    explode(a, b)
  end
end

function explode(a, b)
  local enemy
  local rocket
  if a:getUserData() == 'enemy' then
    enemy = a
    rocket = b
  else 
    rocket = a
    enemy = b
  end

  for i,o in ipairs(data.rockets) do
    if o.fixture == rocket then
      rocket = o

      for j,o in ipairs(data.enemies) do
        if o.fixture == enemy then

          local x,y = rocket.body:getPosition()
          local explosion = {
            x = x,
            y = y,
            scale = math.random(.2, 2)
          }

          enemy = o
          enemy.hp = enemy.hp - rocket.power * explosion.scale
          enemy.hitTime = .1

          explosion.animation = anim8.newAnimation(data.explosionGrid('1-8', '1-8'), 0.01, function (r) 
            for i,o in ipairs(data.explosions) do
              if o.animation == r then
                table.remove(data.explosions, i)
              end
            end
          end)
          table.insert(data.explosions, explosion)
          table.remove(data.rockets, i)

          if enemy.hp <= 0 then
            enemy.fixture:destroy() 
            table.remove(data.enemies, j)
          end
        end
      end
    
    end
  end


end
-- load assets
function scene:init()
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 15 *64, true)
  world:setCallbacks(beginContact)

  data.objects.sky = {}
  data.objects.sky.body = love.physics.newBody(world, 1024/2, -50)
  data.objects.sky.shape = love.physics.newRectangleShape(1024, 100)
  data.objects.sky.fixture = love.physics.newFixture(data.objects.sky.body, data.objects.sky.shape)

  data.objects.right = {}
  data.objects.right.body = love.physics.newBody(world, 1024+50+500, 768/2)
  data.objects.right.shape = love.physics.newRectangleShape(100, 786)
  data.objects.right.fixture = love.physics.newFixture(data.objects.right.body, data.objects.right.shape)

  data.objects.left = {}
  data.objects.left.body = love.physics.newBody(world, -50, 768/2)
  data.objects.left.shape = love.physics.newRectangleShape(100, 768)
  data.objects.left.fixture = love.physics.newFixture(data.objects.left.body, data.objects.left.shape)


  data.objects.player = {}
  data.objects.player.body = love.physics.newBody(world, 150, 384, 'dynamic')
  data.objects.player.shape = love.physics.newRectangleShape(50, 50)
  data.objects.player.fixture = love.physics.newFixture(data.objects.player.body, data.objects.player.shape, 10)

  psystem = lg.newParticleSystem(Assets.star_particle, 100)
  psystem:setParticleLifetime(1, 5)
  psystem:setEmissionRate(10000)
  psystem:setSizeVariation(1)
  psystem:setSpeed(50, 200)
  psystem:setSpin(1, 4*math.pi)
  psystem:setLinearAcceleration(-500, 100, -5000, 200)
  psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0)

  addEnemy()

  data.explosionGrid = anim8.newGrid(512, 512, Assets.explosion:getWidth(), Assets.explosion:getHeight())
end


-- render your scene
function scene:draw()
  lg.setColor(1, 1, 1)
  local bgWidth, bgHeight = getImageScaleForNewDimensions( Assets.mlpbg, 1024, 768 )
  local playerWidth, playerHeight = getImageScaleForNewDimensions(Assets.rainbowDash, 100, 100)
  local playerX, playerY = data.objects.player.body:getPosition()

  local emitterX, emitterY = psystem:getPosition()
  lg.draw(Assets.mlpbg, data.bgX, 0, 0, bgWidth, bgHeight)
  lg.draw(Assets.mlpbg, data.bgX+1024, 0, 0, bgWidth, bgHeight)
  lg.draw(psystem, 0, 0, 0, .05, .05)
  lg.draw(Assets.rainbowDash, playerX, playerY, 0, playerWidth, playerHeight, 175, 175)
  


  for i, o in pairs(data.enemies) do 
    if o.hitTime > 0 then
      lg.setColor(1, 0, 0)
    end
    local enemyX, enemyY = o.body:getPosition()
    lg.draw(Assets.elon, enemyX, enemyY, 0, 1, 1, 180, 150)

    lg.setColor(.2, .2, .2)
    lg.rectangle('fill', 730, 450, o.hpBarWidth, 10)

    lg.setColor(1, 0, 0)
    lg.rectangle('fill', 730, 450, o.hpBarWidth * (o.hp / o.maxHp), 10)
  end

  lg.setColor(1,1,1)
  for i,o in pairs(data.explosions) do
    o.animation:draw(Assets.explosion, o.x-128*o.scale, o.y-128*o.scale, 0, o.scale, o.scale)
  end

  lg.setColor(1, 1,1)

  for i,o in pairs(data.rockets) do
    local rocketX, rocketY = o.body:getPosition()
    lg.draw(Assets.bfr, rocketX, rocketY, o.body:getAngle(), .8, .8, 128*0.5, 378*0.5)
  end
  

  lg.setColor(1, 0, 0, .2)

  if data.debug then
    for i, o in pairs(data.objects) do 
      lg.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
    end
    for i, o in pairs(data.rockets) do 
      lg.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
    end
    for i, o in pairs(data.enemies) do 
      lg.polygon("fill", o.body:getWorldPoints(o.shape:getPoints()))
    end
  end

end

-- update your logic
function scene:update(dt)
  for i, o in pairs(data.enemies) do 
    if o.hitTime > 0 then
      o.hitTime = o.hitTime - dt
    end
  end

  for i,o in pairs(data.explosions) do
    o.animation:update(dt)
  end


  local playerX, playerY = data.objects.player.body:getPosition()
  world:update(dt)
  data.rocketTimer = data.rocketTimer - dt
  psystem:setPosition(playerX * 16, playerY * 16)
  psystem:update(dt)
  local down = love.keyboard.isDown

  if down("space") and data.rocketTimer <= 0 then
    shoot(playerX, playerY)
    data.rocketTimer = data.cooldown
  end

  if down("up") then
    data.objects.player.body:applyForce(0, -data.jumpForce* 100)
  end

  if down("left") then
    data.objects.player.body:applyForce(-64*64, 0)
  end

  if down("right") then
    data.objects.player.body:applyForce(64*64, 0)
  end
  
  data.bgX = data.bgX - data.bgSpeed*dt

  if data.bgX<= -1024 then
    data.bgX = 0 
  end


  if playerX > 900 then
    data.objects.player.body:setLinearVelocity(-10* 64, 0)
  end

  if playerY > 700 then
    data.objects.player.body:setLinearVelocity(0, -10* 64)
  end
end

-- handle input
function scene:keypressed(key, code)
end

function getImageScaleForNewDimensions( image, newWidth, newHeight )
  local currentWidth, currentHeight = image:getDimensions()
  return ( newWidth / currentWidth ), ( newHeight / currentHeight )
end

return scene
