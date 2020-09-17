=begin
    1. Strip and replace these chars. We transform " + " into " | " in order to lightly parse with splits
    2. Split each element by "+"
    3. Remove all the empty elements in this 2d array
=end
def lexer(str)

    splitted_equation = str.gsub(" - ", "|-").gsub(" + ", " | ").gsub(" ", "").upcase().split("=")
    raise("More than 2 parts in the equation") if splitted_equation.length() != 2
    normalized_equation = splitted_equation.map { |el| el.split("|") }
                                   .map { |el| el.filter { |e| !e.empty? }}
                                   .map { |el| el.map {|e| e.gsub("--", "") }}

    return normalized_equation
end



def parser(elements)

    # Array that will contain the 2d arrays of parsed data
    array_hash_2d = elements.map.with_index { |el, i|
        
        tmp_hash = {}
        el.each { |e|

            # Check that the letter X is present
            raise("Put an X variable my dear") unless e.match?(/\*X\^/)
            # Check that the multiplier is an int (or a float)
            # raise("Put a real int please") if e.match(/^((?:|[+-])\d*)\*/).nil? # <- works with int
            raise("Put a real int please") if e.match(/^((?:|[+-])(\d+(\.\d+)?))\*/).nil?
            # Check that the exponent is an int
            raise("Put a valid exponent please") if e.match(/\^((?:|[+-])\d*)$/).nil?

            # Create hash + collect exponent and slope coefficient
            exponent = e.split("^")[1].to_i
            slope_coeff = e.split("*")[0].to_f
            tmp_hash["x_#{exponent}"] = slope_coeff

        }

        tmp_hash
    }

    # Create minimized datastruct 
    minimized_equation = Hash.new(0)
    # Add values left of equation to datastruct
    array_hash_2d[0].each { |key, value| minimized_equation[key] += value }
    # Substract values left of equation to datastruct
    array_hash_2d[1].each { |key, value| minimized_equation[key] -= value }
    # Remove keys that compensated
    minimized_equation = minimized_equation.filter {|key, value| value != 0 }

    minimized_equation.each { |key, value|
        raise("Put a valid exponent please") if key != "x_0" && key != "x_1" && key != "x_2" 
    }
    
    return minimized_equation
end

def execute(str)
    
    normalized_equation = lexer(str)
    datastruct = parser(normalized_equation)
    
    print datastruct
    
end

def main()

    print("Enter your input: ")
    str = gets.chomp
    begin
        execute(str)
    rescue => e
        puts "\nError: \"#{e}\""
        exit 1
    end

end

main()