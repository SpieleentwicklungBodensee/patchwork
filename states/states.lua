local folders = love.filesystem.getDirectoryItems("states")


local level_list = {}
for k,v in pairs(folders) do
    local idx = v:find("lua")
    
    --check if it is a lua file,else it is a folder or something else...
    if idx == nil then
        
    else
        local level_name= v:sub(1,idx-2)
        if level_name ~= "states" then
            level_list[level_name] = require("states.".. level_name)
        end
    end
end

return level_list