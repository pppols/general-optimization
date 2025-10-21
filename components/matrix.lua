require("components.vector")

matrix = {

    new = function(rows, columns, value)

        local identity = value == true
        local value = type(value) == "number" and value or 0
        local result = setmetatable({rows = rows, columns = columns}, matrix)

        for i = 1, rows do

            result[i] = {}

            for j = 1, columns do

                result[i][j] = identity and (i == j) and 1 or value

            end

        end

        return result
        
    end,

    copy = function(array)

        local result = setmetatable({rows = #array, columns = #array[1]}, matrix)

        for i = 1, result.rows do
            
            result[i] = {}

            for j = 1, result.columns do
                
                result[i][j] = array[i][j]

            end

        end

        return result
        
    end,

    __add = function(a, b)

        local result = setmetatable({rows = a.rows, columns = a.columns}, matrix)

        for i = 1, a.rows do
            
            result[i] = {}

            for j = 1, a.columns do
                
                result[i][j] = a[i][j] + b[i][j]

            end

        end

        return result
        
    end,

    __sub = function(a, b)

        local result = setmetatable({rows = a.rows, columns = a.columns}, matrix)

        for i = 1, a.rows do
            
            result[i] = {}

            for j = 1, a.columns do
                
                result[i][j] = a[i][j] - b[i][j]

            end

        end

        return result
        
    end,

    __mul = function(a, b)

        if type(b) == "table" then
            
            if b.rows then

                result = setmetatable({rows = a.rows, columns = b.columns}, matrix)
                
                for i = 1, a.rows do
                    
                    result[i] = {}

                    for j = 1, b.columns do
                        
                        local sum = 0

                        for n = 1, a.columns do
                            
                            sum = sum + a[i][n] * b[n][j]

                        end

                        result[i][j] = sum

                    end

                end

            else

                result = vector.empty(b.size)
            
                for i = 1, a.rows do
                    
                    local sum = 0

                    for j = 1, a.columns do
                        
                        sum = sum + a[i][j] * b[j]

                    end

                    result[i] = sum

                end

            end

        else

            result = setmetatable({rows = a.rows, columns = a.columns}, matrix)

            for i = 1, a.rows do
                
                result[i] = {}

                for j = 1, a.columns do
                    
                    result[i][j] = a[i][j] * b

                end

            end

        end

        return result
        
    end,

    __unm = function(a)

        local result = matrix.new(a.rows, a.columns)

        for y = 1, a.rows do
            
            for x = 1, a.columns do
                
                result[y][x] = -a[y][x]

            end

        end

        return result
        
    end,

    transpose = function(a)

        local result = matrix.new(a.columns, a.rows)

        for y = 1, a.columns do
            
            for x = 1, a.rows do
                
                result[y][x] = a[x][y]

            end

        end

        return result
        
    end,

    print = function(a)

        for y = 1, a.rows do
            
            local row = ""

            for x = 1, a.columns do
                
                local element = a[y][x]
                row = row .. ", " .. element

            end

            row = row:sub(3)
            print(row)

        end
        
    end

}