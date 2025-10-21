require('components.matrix')

lil_matrix = {

    new = function(rows, columns)

        local result = setmetatable({rows = rows, columns = columns}, lil_matrix)
        
        for i = 1, rows do
            
            result[i] = {count = 0}

        end

        return result
        
    end,

    from_matrix = function(matrix)

        local result = lil_matrix.new(matrix.rows, matrix.columns)

        for i = 1, matrix.rows do
            
            for j = 1, matrix.columns do
                
                local value = matrix[i][j]

                if value ~= 0 then
                    lil_matrix.append(result, i, j, value)
                end

            end

        end

        return result
        
    end,

    insert = function(self, row, column, value)

        local matrix_row = self[row]
        matrix_row.count = matrix_row.count + 1
        
        for i = matrix_row.count, 1, -1 do

            local matrix_node = matrix_row[i]

            if column < matrix_node.column then
                
                table.insert(matrix_row, i, {column = column, value = value})
                break

            end

        end
        
    end,
    
    append = function(self, row, column, value)

        local matrix_row = self[row]
        matrix_row.count = matrix_row.count + 1

        matrix_row[matrix_row.count] = {column = column, value = value}
        
    end

}