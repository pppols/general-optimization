require('library.vector')
require('library.matrix')

quaternion = {

    ---constructs quaternion from given values, defaults to zero for excluded values
    ---@param w number
    ---@param x number
    ---@param y number
    ---@param z number
    ---@return quaternion
    new = function(w, x, y, z)

        local result = {
            w=w or 0,
            x=x or 0,
            y=y or 0,
            z=z or 0
        }

        return setmetatable(result, quaternion)
        
    end,



    ---adds two quaternions
    ---@param a quaternion
    ---@param b quaternion
    ---@return quaternion
    __add = function(a, b)

        local result = {
            w = a.w + b.w,
            x = a.x + b.x,
            y = a.y + b.y,
            z = a.z + b.z
        }

        return setmetatable(result, quaternion)
        
    end,

    ---subtracts two quaternions
    ---@param a quaternion
    ---@param b quaternion
    ---@return quaternion
    __sub = function(a, b)

        local result = {
            w = a.w - b.w,
            x = a.x - b.x,
            y = a.y - b.y,
            z = a.z - b.z
        }

        return setmetatable(result, quaternion)
        
    end,

    ---multiplies a quaternion with another value, contextually:  
    --- -quaternion: quaternion quaterion multiplication  
    --- -scalar: quaternion scalar multiplication
    ---@param a quaternion
    ---@param b any
    ---@return quaternion
    __mul = function(a, b)

        --quaternion quaternion multiplication
        if getmetatable(b) == quaternion then
            
            local result = {
                w = a.w*b.w - a.x*b.x - a.y*b.y - a.z*b.z,
                x = a.w*b.x + a.x*b.w + a.y*b.z - a.z*b.y,
                y = a.w*b.y - a.x*b.z + a.y*b.w + a.z*b.x,
                z = a.w*b.z + a.x*b.y - a.y*b.x + a.z*b.w
            }

            return setmetatable(result, quaternion)

        end


        --quaternion scalar multiplication
        local result = {
            w = a.w*b,
            x = a.x*b,
            y = a.y*b,
            z = a.z*b
        }

        return setmetatable(result, quaternion)
        
    end,

    ---returns quaternion representing a given axis angle
    ---@param axis vector
    ---@param angle number
    ---@return quaternion
    axis_angle = function(axis, angle)

        local cos2 = math.cos(angle*0.5)
        local sin2 = math.sin(angle*0.5)

        local result = {
            w = cos2,
            x = sin2 * axis.x,
            y = sin2 * axis.y,
            z = sin2 * axis.z
        }

        return setmetatable(result, quaternion)
        
    end,

    ---returns the magnitude for a quaternion
    ---@param a quaternion
    ---@return number
    magnitude = function(a)

        return math.sqrt(a.w*a.w + a.x*a.x + a.y*a.y + a.z*a.z)
        
    end,

    ---returns the squared magnitude for a quaternion
    ---@param a quaternion
    ---@return number
    magnitude2 = function(a)

        return a.w*a.w + a.x*a.x + a.y*a.y + a.z*a.z
        
    end,

    ---applies the quaternion to rotate a vector through decomposition into rodrigues formula
    ---@param a quaternion
    ---@param b vector
    ---@return vector
    rotate_vector = function(a, b)

        local axis = vector.new(a.x, a.y, a.z)
        local scalar = a.w

        local axis_part = axis * vector.dot(axis, b) * 2
        local vector_part = b * (scalar*scalar - vector.magnitude2(axis))
        local cross_part = vector.cross(axis, b) * scalar * 2
        return axis_part + vector_part + cross_part
        
    end,



    --debug
    __tostring = function(a)

        return string.format('[%.3f, %.3f, %.3f, %.3f]', a.w, a.x, a.y, a.z)
        
    end

}