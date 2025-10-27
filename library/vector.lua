vector = {

    ---creates a new vector from given values
    ---@param ... value
    ---@return vector
    new = function(...)
    
        local result = {...}
        result.size = #result
        return setmetatable(result, vector)

    end,

    ---creates a new empty vector of all zeroes
    ---@param size integer
    ---@return vector
    empty = function(size)

        local result = {size = size}

        for i = 1, size do
            result[i] = 0
        end

        return setmetatable(result, vector)
        
    end,

    ---creates a new vector of a given constant value
    ---@param size integer
    ---@param value number
    ---@return vector
    constant = function(size, value)

        local value = value or 0
        local result = {size = size}

        for i = 1, size do
            result[i] = value
        end

        return setmetatable(result, vector)
        
    end,

    ---creates a copy of a given vector
    ---@param a vector
    ---@return vector
    copy = function(a)

        local result = {size = a.size}
        
        for i = 1, a.size do
            result[i] = a[i]
        end

        return setmetatable(result, vector)
        
    end,



    __index = function(self, element)

        return vector[element]
        
    end,

    ---adds two vectors
    ---@param a vector
    ---@param b vector
    ---@return vector
    __add = function(a, b)

        local result = {size = a.size}

        for i = 1, a.size do
            result[i] = a[i] + b[i]
        end

        return setmetatable(result, vector)
        
    end,

    ---subtracts two vectors
    ---@param a vector
    ---@param b vector
    ---@return vector
    __sub = function(a, b)

        local result = {size = a.size}

        for i = 1, a.size do
            result[i] = a[i] - b[i]
        end

        return setmetatable(result, vector)
        
    end,

    ---multiplies a vector
    ---@param a vector
    ---@param b number
    ---@return vector
    __mul = function(a, b)

        local result = {size = a.size}

        for i = 1, a.size do
            result[i] = a[i] * b
        end

        return setmetatable(result, vector)
        
    end,

    ---divides a vector
    ---@param a vector
    ---@param b number
    ---@return vector
    __div = function(a, b)

        local result = {size = a.size}
        local reciprocal = 1 / b

        for i = 1, a.size do
            result[i] = a[i] * reciprocal
        end

        return setmetatable(result, vector)
        
    end,

    ---unary minus
    ---@param a vector
    ---@return vector
    __unm = function(a)

        local result = {size = a.size}

        for i = 1, a.size do
            result[i] = -a[i]
        end

        return setmetatable(result, vector)
        
    end,

    ---returns the dot product of two vectors
    ---@param a vector
    ---@param b vector
    ---@return number
    dot = function(a, b)

        local sum = 0

        for i = 1, a.size do
            sum = sum + a[i]*b[i]
        end

        return sum
        
    end,

    ---returns the magnitude of the input
    ---@param a vector
    ---@return number
    magnitude = function(a)

        local sum = 0

        for i = 1, a.size do
            sum = sum + a[i]*a[i]
        end

        return math.sqrt(sum)
        
    end,

    ---returns the squared magnitude of the input
    ---@param a vector
    ---@return number
    magnitude2 = function(a)

        local sum = 0

        for i = 1, a.size do
            sum = sum + a[i]*a[i]
        end

        return sum
        
    end,

    ---normalizes a vector, returns a zero vector for zero inputs
    ---@param a vector
    ---@return vector
    normalize = function(a)

        local magnitude = vector.magnitude(a)
        
        if magnitude == 0 then
            return a
        end

        return a / magnitude
        
    end,

    ---cross product of two vectors in 3d
    ---@param a vector
    ---@param b vector
    ---@return vector
    cross = function(a, b)

        local result = {
            a[2]*b[3] - a[3]*b[2],
            a[3]*b[1] - a[1]*b[3],
            a[1]*b[2] - a[2]*b[1]
        }
        
        result.size = 3
        return setmetatable(result, vector)
        
    end,



    --debug
    __tostring = function(a)

        local result = ''

        for i = 1, a.size do
            result = string.format('%s, %.3f', result, a[i])
        end

        result = result:sub(3)
        result = '[' .. result .. ']'
        return result
        
    end

}