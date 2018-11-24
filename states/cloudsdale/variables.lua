local objects = {}
local debug = false
local psystem = nil
local bgX = 0
local bgSpeed = 700
local explosionGrid
local explosions = {}

local enemies = {}
local rockets = {}
local cooldown = .25
local rocketTimer = 0

local gravity = 100
local jumpForce = 6 * 64

return {
    objects = objects,
    debug = debug,
    psystem = psystem,
    bgX = bgX,
    bgSpeed = bgSpeed,
    enemies = enemies,
    rockets = rockets,
    cooldown = cooldown,
    rocketTimer = rocketTimer,
    gravity = gravity,
    jumpForce = jumpForce,
    explosions = explosions
}