equation = {

    new = function(input_dimension, output_dimension)

        local self = {

            __equation = nil,
            derivative = {},
            input_dimension = input_dimension or 0,
            output_dimension = output_dimension or 0,

        }

        return setmetatable(self, equation)
        
    end,

    set_equation = function(self, equation)

        self.__equation = equation
        
    end,

    set_derivative = function(self, order, equation)

        self.derivative[order] = equation
        
    end,

    __index = function(self, key)

        return equation[key]
        
    end,

    __call = function(self, arguments)

        return self.__equation(arguments)
        
    end

}