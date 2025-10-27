require('library.vector')
require('library.matrix')
require('library.lil matrix')

csr_matrix = {

    ---creates a compressed sparse row formatted matrix from a given list of list matrix
    ---@param a lil_matrix
    ---@return csr_matrix
    from_lil = function(a)

        local result = {rows = a.rows, columns = a.columns}
        result.count = 0
        result.data = {}
        result.column_index = {}
        result.row_index = {}

        local offset = 1

        for i = 1, a.rows do
            
            result.row_index[i] = offset
            local row = a[i]

            for j = 1, row.count do
                
                local node = row[j]
                result.count = result.count + 1
                result.data[result.count] = node.value
                result.column_index[result.count] = node.column

            end

            offset = offset + row.count

        end

        result.row_index[a.rows + 1] = offset

        return setmetatable(result, csr_matrix)
        
    end,



    __mul = function(a, b)

        if getmetatable(b) == vector then

            local result = {size = a.rows}
            local count = a.count
            local data = a.data
            local column_index = a.column_index
            local row_index = a.row_index
            local start_index = 1

            for i = 1, a.rows do
                
                local sum = 0
                local end_index = row_index[i+1]

                for j = start_index, end_index - 1 do
                    
                    local column = column_index[j]
                    sum = sum + data[j]*b[column]

                end

                start_index = end_index
                result[i] = sum

            end

            return setmetatable(result, vector)
            
        end

        --todo: include other operations
        
    end,



    --debug
    __tostring = function(a)
        
        local result = ''
        local count = a.count
        local data = a.data
        local column_index = a.column_index
        local row_index = a.row_index

        for i = 1, a.rows do
            
            local start_index = row_index[i]
            local end_index = row_index[i+1]
            local row_string = ''
            local last_index = 0

            for j = start_index, end_index do
                
                local value = data[j]
                local index = column_index[j]

                if j < end_index then
                    
                    row_string = row_string .. string.rep(', 0.000', index - last_index - 1)
                    row_string = row_string .. string.format(', %.3f', value)

                else
                
                    row_string = row_string .. string.rep(', 0.000', a.columns - last_index)

                end

                last_index = index

            end

            row_string = row_string:sub(3)
            row_string = '[' .. row_string .. ']'
            result = result .. '\n' .. row_string

        end

        result = result:sub(2)
        return result

    end

}