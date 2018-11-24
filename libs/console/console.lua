local console = {}

local buffer = {}
local buffer_max = 30
local x,y =0,0
local w,h =200,50


function console.log(text)
 -- if #buffer>=buffer_max then
 --   table.remove(buffer,buffer_max)
 -- end
  
  while #buffer >= buffer_max do
    table.remove(buffer,buffer_max)
  end
  
  table.insert(buffer,1,text)

end



function console.draw()
  love.graphics.rectangle("line",x,y,w,h)
  love.graphics.print(table.concat(buffer,"\n"),x+5,y+5)
end

function console.setPos(px,py)
    x = px
    y = py
end

function console.setSize(pw,ph)
    w =pw
    h =ph
end


function console.setBuff(size)
  buffer_max = size
end

return console