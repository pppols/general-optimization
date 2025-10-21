require('components.matrix')
require('components.lil matrix')

csr_matrix = {

    from_lil = function(matrix)

        local result = setmetatable({rows = matrix.rows, columns = matrix.columns}, csr_matrix)
        result.data = {count = 0}
        result.column_index = {}
        result.row_index = {}

        local offset = 1

        for i = 1, matrix.rows do
            
            result.row_index[i] = offset
            local matrix_row = matrix[i]
            
            for j = 1, matrix_row.count do
                
                local matrix_node = matrix_row[j]
                result.data.count = result.data.count + 1
                result.data[result.data.count] = matrix_node.value
                result.column_index[result.data.count] = matrix_node.column

            end

            offset = offset + matrix_row.count

        end

        result.row_index[matrix.rows + 1] = offset

        return result
        
    end,

    multiply_dense_vector = function(a, b)

        local result = setmetatable({rows = a.rows, columns = 1}, matrix)
        local data = a.data
        local column_index = a.column_index
        local row_index = a.row_index

        for i = 1, a.rows do
            
            result[i] = {}
            result[i][1] = 0
            local start_index = row_index[i]
            local end_index = row_index[i+1]

            for j = start_index, end_index - 1 do
                
                local value = data[j]
                local column = column_index[j]
                result[i][1] = result[i][1] + b[column][1]*value

            end

        end

        return result
        
    end

}