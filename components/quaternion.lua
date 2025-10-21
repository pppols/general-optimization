quaternion = {

    new = function(w, x, y, z)
        
        local w, x, y, z = w or 0, x or 0, y or 0, z or 0
        local result = setmetatable({w=w, x=x, y=y, z=z}, quaternion)
        return result

    end,

    add = function(a, b)
        
        local result = setmetatable(
            {
                w = a.w + b.w,
                x = a.x + b.x,
                y = a.y + b.y,
                z = a.z + b.z
            }, 
            quaternion
        )

        return result

    end,

    subtract = function(a, b)
        
        local result = setmetatable(
            {
                w = a.w - b.w,
                x = a.x - b.x,
                y = a.y - b.y,
                z = a.z - b.z
            }, 
            quaternion
        )

        return result

    end,

    multiply = function(a, b)

        local result = setmetatable(
            {
                w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z,
                x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y,
                y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x,
                z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w
            },
            quaternion
        )

        return result
        
    end,

    axis_angle = function(axis, angle)

        local result = setmetatable({}, quaternion)

        local cos2 = 0.5*math.cos(angle)
        local sin2 = 0.5*math.sin(angle)
        result.w = cos2
        result.x = sin2*axis.x
        result.y = sin2*axis.y
        result.z = sin2*axis.z

        return result
        
    end,

    magnitude2 = function(a)

        return a.w*a.w + a.x*a.x + a.y*a.y + a.z*b.z
        
    end,

    magnitude = function(a)

        return math.sqrt(a.w*a.w + a.x*a.x + a.y*a.y + a.z*a.z)
        
    end,

    scale = function(a, b)

        return {
            w = a.w*b,
            x = a.x*b,
            y = a.y*b,
            z = a.z*b
        }
        
    end

}