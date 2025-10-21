vector = {

    new = function(...)

        local result = {...}
        result.size = #result
        return setmetatable(result, vector)

    end,

    empty = function(size)

        local result = {size = size}
        return setmetatable(result, vector)
        
    end,

    constant = function(size, value)

        local value = value or 0
        local result = {size = size}

        for i = 1, size do
            result[i] = value
        end

        return setmetatable(result, vector)

    end,

    copy = function(a)

        local result = {size = a.size}

        for i = 1, a.size do
            result[i] = a[i]
        end

        return setmetatable(result, vector)
        
    end,

    __add = function(a, b)

        local result = vector.empty(a.size)

        for i = 1, a.size do
            result[i] = a[i] + b[i]
        end

        return result

    end,

    __sub = function(a, b)
        
        local result = vector.empty(a.size)

        for i = 1, a.size do
            result[i] = a[i] - b[i]
        end

        return result

    end,

    __mul = function(a, b)

        local result = vector.empty(a.size)

        for i = 1, a.size do
            result[i] = a[i] * b
        end

        return result
        
    end,

    __div = function(a, b)

        local result = vector.empty(a.size)
        local reciprocal = 1 / b

        for i = 1, a.size do
            result[i] = a[i] * reciprocal
        end

        return result
        
    end,

    __unm = function(a)

        local result = vector.empty(a.size)

        for i = 1, a.size do
            result[i] = -a[i]
        end

        return result
        
    end,

    dot = function(a, b)

        local result = 0

        for i = 1, a.size do
            result = result + a[i] * b[i]
        end

        return result
        
    end,

    magnitude = function(a)

        local result = 0

        for i = 1, a.size do
            result = result + a[i]*a[i]
        end

        return math.sqrt(result)
        
    end,

    magnitude2 = function(a)

        local result = 0

        for i = 1, a.size do
            result = result + a[i]*a[i]
        end

        return result
        
    end,

    normalize = function(a)

        local magnitude = vector.magnitude(a)

        if magnitude == 0 then
            return a
        end

        return a / magnitude
        
    end,

    cross = function(a, b)

        return vector.new(
            a[2]*b[3] - a[3]*b[2],
            a[3]*b[1] - a[1]*b[3],
            a[1]*b[2] - a[2]*b[1]
        )
        
    end

}