require('library.vector')
require('library.matrix')

lil_matrix = {

    ---creates a new list of list formatted matrix
    ---@param rows integer
    ---@param columns integer
    ---@return lil_matrix
    new = function(rows, columns)
    
        local result = {rows = rows, columns = columns}

        for i = 1, rows do
            
            result[i] = {count = 0}

        end

        return setmetatable(result, lil_matrix)

    end,

    ---creates a copy of the given matrix
    ---@param a lil_matrix
    ---@return lil_matirx
    copy = function(a)

        local result = {rows = a.rows, columns = a.columns}

        for i = 1, rows do
            
            local row = a[i]
            result[i] = {count = row.count}

            for j = 1, row.count do
                result[i][j] = a[i][j]
            end

        end

        return setmetatable(result, lil_matrix)
        
    end,

    ---creates a list of list matrix from a given matrix
    ---@param a matrix
    ---@return lil_matrix
    from_matrix = function(a)
        
        local result = {rows = a.rows, columns = a.columns}

        for i = 1, a.rows do
            
            result[i] = {count = 0}

            for j = 1, a.columns do
                
                local value = a[i][j]

                if value ~= 0 then
                    lil_matrix.append(result, i, j, value)
                end

            end

        end

        return setmetatable(result, lil_matrix)

    end,

    ---inserts an element into the list of lists
    ---@param self lil_matrix
    ---@param row integer
    ---@param column integer
    ---@param value number
    insert = function(self, row, column, value)

        local matrix_row = self[row]

        for i = matrix_row.count, 1, -1 do
            
            local matrix_node = matrix_row[i]

            if column < matrix_node.column then
                
                table.insert(matrix_row, i, {column = column, value = value})
                matrix_row.count = matrix_row.count + 1
                break

            end

        end
        
    end,

    ---inserts an element into the list of lists, assuming the insertion order is sorted
    ---@param self lil_matrix
    ---@param row integer
    ---@param column integer
    ---@param value number
    append = function(self, row, column, value)

        local matrix_row = self[row]
        matrix_row.count = matrix_row.count + 1
        matrix_row[matrix_row.count] = {column = column, value = value}
        
    end,



    --debug
    __tostring = function(a)

        local result = ''

        for i = 1, a.rows do
            
            local row_string = ''
            local last_index = 0
            local row = a[i]

            for j = 1, row.count + 1 do
                
                if j <= row.count then
                    
                    local node = row[j]
                    local index = node.column
                    local value = node.value

                    row_string = row_string .. string.rep(', 0.000', index - last_index - 1)
                    row_string = row_string .. string.format(', %.3f', value)
                    last_index = index

                else
                
                    row_string = row_string .. string.rep(', 0.000', a.columns - last_index)

                end

            end

            row_string = row_string:sub(3)
            row_string = '[' .. row_string .. ']'
            result = result .. '\n' .. row_string

        end

        result = result:sub(2)
        return result

    end

}