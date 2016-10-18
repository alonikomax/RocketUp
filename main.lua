require "rocket/rocket"

function love.load()
  -- Settings
  love.graphics.setBackgroundColor( 50, 150, 200, 255 )
  rc = Rocket(love.graphics.newImage("simpleRocket.png"), 1000, 900)
  love.graphics.setBackgroundColor(0, 118, 207)
  font = love.graphics.newImageFont("coolFont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  love.graphics.setFont(font, 27)
  love.window.setMode(650, 650)

  -- Game spesific
  cake_x = love.graphics.getWidth()/3
  cake_y = 200

  -- Physics
  love.physics.setMeter(64)
  world = love.physics.newWorld(0, 9.81*64, true)
  objects = {}
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(650, 50)
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
  objects.ball = {}
  objects.ball.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  objects.ball.shape = love.physics.newCircleShape(20)
  objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1)
  objects.ball.fixture:setRestitution(0.9)
end

function love.update(dt)
  world:update(dt)
  rc:update(dt)
  --rc:right(dt)
end

function love.draw()
  rc:draw()
  love.graphics.setColor(72, 160, 14)
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
  love.graphics.setColor(193, 47, 14)
  love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
  love.graphics.setBackgroundColor( 50, 150, 200, 255 )
end

function love.touchpressed(id, x, y, dx, dy, pressure)
  rc:touchpressed(id, x)
end

function love.touchmoved(id, x, y, dx, dy, pressure)
  -- body...
end

function love.touchreleased(id, x, y, dx, dy, pressure)
  rc:touchreleased(id, x, y, dx, dy, pressure)
end
