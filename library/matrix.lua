require('library.vector')

matrix = {

    ---constructs a matrix of desired size, with a contextual default value:  
    --- -number: sets every entry to the provided value  
    --- -empty: sets every entry to zero  
    --- -boolean: identity matrix
    ---@param rows integer
    ---@param columns integer
    ---@param value any
    ---@return matrix
    new = function(rows, columns, value)
        
        local identity = value == true
        local value = (type(value) == 'number') and value or 0
        local result = {rows = rows, columns = columns}

        for i = 1, rows do

            result[i] = {}

            for j = 1, columns do
                result[i][j] = (identity and i == j) and 1 or value
            end

        end

        return setmetatable(result, matrix)

    end,

    ---creates a copy of the given matrix
    ---@param a matrix
    ---@return matrix
    copy = function(a)
        
        local result = {rows = a.rows, columns = a.columns}

        for i = 1, a.rows do

            result[i] = {}

            for j = 1, a.columns do
                result[i][j] = a[i][j]
            end

        end

        return setmetatable(result, matrix)

    end,



    __index = function(self, element)

        return matrix[element]
        
    end,

    ---adds two given matrices
    ---@param a matrix
    ---@param b matrix
    ---@return matrix
    __add = function(a, b)

        local result = {rows = a.rows, columns = a.columns}

        for i = 1, a.rows do

            result[i] = {}

            for j = 1, a.columns do
                result[i][j] = a[i][j] + b[i][j]
            end

        end

        return setmetatable(result, matrix)
        
    end,

    ---subtracts two given matrices
    ---@param a matrix
    ---@param b matrix
    ---@return matrix
    __sub = function(a, b)

        local result = {rows = a.rows, columns = a.columns}

        for i = 1, a.rows do

            result[i] = {}

            for j = 1, a.columns do
                result[i][j] = a[i][j] - b[i][j]
            end

        end

        return setmetatable(result, matrix)
        
    end,

    ---multiplies a matrix and a given value contextually, either:  
    --- -matrix: naive matrix matrix multiplication  
    --- -vector: naive matrix vector multiplication  
    --- -number: naive matrix scalar multiplication
    ---@param a matrix
    ---@param b any
    ---@return any
    __mul = function(a, b)
        
        --matrix matrix multiplication
        if getmetatable(b) == matrix then
            
            local result = {rows = a.rows, columns = a.columns}

            for i = 1, a.rows do
                
                result[i] = {}
                
                for j = 1, b.columns do
                    
                    local sum = 0

                    for k = 1, a.columns do
                        sum = sum + a[i][k] * b[k][j]
                    end

                    result[i][j] = sum

                end

            end

            return setmetatable(result, matrix)

        end


        --matrix vector multiplication
        if getmetatable(b) == vector then
            
            local result = {size = a.rows}

            for i = 1, a.rows do
                
                local sum = 0

                for j = 1, a.columns do
                    sum = sum + a[i][j] * b[j]
                end

                result[i] = sum

            end

            return setmetatable(result, vector)

        end


        --matrix scalar multiplication
        local result = {rows = a.rows, columns = a.columns}

        for i = 1, result.rows do

            result[i] = {}

            for j = 1, result.columns do
                result[i][j] = a[i][j] * b
            end

        end

        return setmetatable(result, matrix)

    end,

    ---unary minus
    ---@param a matrix
    ---@return matrix
    __unm = function(a)

        local result = {rows = a.rows, columns = a.columns}

        for i = 1, a.rows do
            
            result[i] = {}

            for j = 1, a.columns do
                result[i][j] = -a[i][j]
            end

        end

        return setmetatable(result, matrix)
        
    end,

    ---returns the transpose of given matrix
    ---@param a matrix
    ---@return matrix
    transpose = function(a)

        local result = {rows = a.columns, columns = a.rows}

        for i = 1, a.columns do
            
            result[i] = {}

            for j = 1, a.rows do
                result[i][j] = a[j][i]
            end

        end

        return setmetatable(result, matrix)
        
    end,



    --debug
    __tostring = function(a)

        local result = ''

        for i = 1, a.rows do
            
            local row = ''

            for j = 1, a.columns do
                row = string.format('%s, %.3f', row, a[i][j])
            end

            row = row:sub(3)
            row = '[' .. row .. ']'
            result = result .. '\n' .. row

        end

        result = result:sub(2)
        return result
        
    end

}