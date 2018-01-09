game_object = { x = 0, y = 0}

function game_object:new(o)
    o = o or {} -- create object if not provided.
    setmetatable(o, self)
    self.__index = self
    return o
end

function game_object:get_center()
    return vector:new({ x = self.x - self.image:getWidth() / 2, y = self.y - self.image:getHeight() / 2 })
end

function game_object:draw(center_of_image)
    center_of_image = center_of_image or true
    if center_of_image then
        local pos = self:get_center()
        love.graphics.draw(self.image, pos.x, pos.y);
    else
        love.graphics.draw(self.image, self.x, self.y);
    end

end

tri_member_func = { a = 2, b = 30, c = 50 }

function tri_member_func:new(o)
    o = o or {} -- create object if not provided.
    setmetatable(o, self)
    self.__index = self
    return o
end

function tri_member_func:L(x)

    return (x - self.a) / (self.b - self.a)
end

function tri_member_func:R(x)
    return (self.c - x) / (self.c - self.b)
end

function tri_member_func:R_value(x)
    if self.b <= x and x <= self.c then
        return self:R(x)
    end

    return 0
end

function tri_member_func:value(x)
    if self.a <= x and x <= self.b then
        return self:L(x)
    elseif self.b < x and x <= self.c then
        return self:R(x)
    end
    return 0
end

vector = {x = 0, y = 0}

function vector:new(o)
    o = o or {} -- create object if not provided.
    setmetatable(o, self)
    self.__index = self
    return o
end

function vector:dot(vec)
    return self.x * vec.x + self.y * vec.y
end

function vector:length()
    return math.sqrt(self:dot(self))
end

function vector:normalized()
    return self / self:length()
end

function vector:get_angle()
    return math.atan2(self.y, self.x)
end

function vector:__add(vec)
    return vector:new({x = self.x + vec.x, y = self.y + vec.y})
end

function vector:__mul(num)
    return vector:new({x = self.x * num, y = self.y * num})
end

function vector:__div(num)
    return vector:new({x = self.x / num, y = self.y / num})
end

function vector:__sub(vec)
    return vector:new({x = self.x - vec.x, y = self.y - vec.y})
end

function DirectionVec(angle_rad)
    return vector:new( {x = math.cos(angle_rad), y = math.sin(angle_rad)} )
end

function Friction(vec, friction)
    local len = vec:length()

    if len == 0 then return vec end 
    
    if len > 0 then
        len = math.max(0, len - friction)
    elseif len < 0 then
        len = math.min(0, len + friction)
    end
    return vec:normalized() * len
end

function clamp(val, lower, upper)
    return math.max(lower, math.min(upper, val))
end

debugGraph = {}

function debugGraph:new(x, y, width, height, sample_size)
    local instance = {
        x = x or 0,
        y = y or 0,
        width = width or 50,
        sample_size = sample_size or width / 2,
        height = height or 30,
        data = {},
    }

    for i = 1, (instance.sample_size) do
        instance.data[i] = 0
    end

    function instance:update(index, value)
        self.data[index] = value
    end

    function instance:draw()
        local lineData = {}
        local len = #self.data
        local steps = self.width / len

        for i = 1, len do
            local x = steps * (i - 1) + self.x
            local y = (-self.data[i]) * self.height + self.y

            table.insert(lineData, x)
            table.insert(lineData, y)
        end
        love.graphics.line(unpack(lineData))
    end

    return instance
end