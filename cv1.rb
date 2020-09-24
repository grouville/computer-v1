=begin
    1. Strip and replace these chars. We transform " + " into " | " in order to lightly parse with splits
    2. Split each element by "+"
    3. Remove all the empty elements in this 2d array
=end
def lexer(str)

    splitted_equation = str.gsub(" - ", "|-").gsub(" + ", " | ").gsub(" ", "").upcase().split("=")
    raise("2 parts expected in the equation") if splitted_equation.length() != 2
    normalized_equation = splitted_equation.map { |el| el.split("|") }
                                   .map { |el| el.filter { |e| !e.empty? }}
                                   .map { |el| el.map {|e| e.gsub("--", "").gsub("-+", "-") }}

    return normalized_equation
end

def parser(elements)

    # Array that will contain the 2d arrays of parsed data
    array_hash_2d = elements.map { |el|
        tmp_hash = {}
            el.each { |e|

                # Check that the letter X is present
                raise("Put an X variable my dear") unless e.match?(/\*X\^/)
                # Check that the multiplier is an int (or a float)
                raise("Put a real int please") if e.match(/^((?:|[+-])(\d+(\.\d+)?))\*/).nil?
                # Check that the exponent is an int
                raise("Put a valid exponent please") if e.match(/\^((?:|[+-])\d*)$/).nil?

                # Create hash + collect exponent and slope coefficient
                exponent = e.split("^")[1].to_i
                slope_coeff = e.split("*")[0].to_f

                # Add similar keys together, or create when new
                if tmp_hash["x_#{exponent}"].nil?
                    tmp_hash["x_#{exponent}"] = slope_coeff else tmp_hash["x_#{exponent}"] += slope_coeff end

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
    minimized_equation = minimized_equation.filter { |key, value| value != 0 }
    # Check that the remaining keys are valid
    minimized_equation.each { |key, value|
        raise("Put a valid exponent please (valid polynomial degree)") if key != "x_0" && key != "x_1" && key != "x_2" 
    }
    
    return minimized_equation

end

def print_minimized_and_degree(datastruct, degree)

    l = -> (number) { a = if number >= 0 then " + " else " - " end ; return a }
    l_max = -> (number) { a = if number >= 0 then "" else "-" end ; return a }
    c = -> (number) { a = if number < 0 then number * -1 else number end ; return a }
    
    max_key = datastruct.keys.max
    str = "\nThe reduced form is : "

    str += "#{datastruct["x_2"].round(5)}x²" unless datastruct["x_2"].nil?
    ["x_1","x_0"].each do | el |
        unless datastruct[el].nil? then
            str += (el == max_key) ? l_max.call(datastruct[el]) : l.call(datastruct[el])
            str += "#{c.call(datastruct[el].round(5))}"
            str += "x" if el == "x_1"
        end
    end
    str += "0" if max_key.nil?
    str += " = 0"

    puts str
    puts "Polynomial degree: #{degree}"

end

def solve_c(datastruct)
     if datastruct["x_0"].nil? then
            puts "All Real numbers are valid" else puts "No solution possible" end
end
  
def solve_linear(datastruct)

    b = datastruct["x_1"]
    c = if datastruct["x_0"].nil? then 0 else datastruct["x_0"] end
    puts "The solution is : #{(-c/b).round(5)}"

end

def solve_second_degree(datastruct)

    my_sqrt = -> (nb) { i = 0.00001; while (i*i) < nb do i += 0.00001 end ; return i.to_f().round(5) }
    discriminant = -> (a,b,c) { b*b - 4*a*c }
    getter = -> (dt, key) { if dt[key].nil? then 0 else dt[key] end }

    a = datastruct["x_2"]
    b = getter.call(datastruct, "x_1")
    c = getter.call(datastruct, "x_0")

    delta = discriminant.call(a,b,c)
    alpha = -b / (2 * a)

    if delta < 0 then
        puts "Delta < 0"
        sqrt = my_sqrt.call(-delta) / (2 * a)
        puts "The two solutions are : \n#{alpha} + i * #{sqrt}  \n#{alpha} - i * #{sqrt}"
    elsif delta == 0 then
        puts "Delta == 0 | solution : #{alpha}"
    else
        puts "Delta > 0"
        sqrt = my_sqrt.call(delta) / (2 * a)
        puts "The two solutions are : \n#{alpha + sqrt}  \n#{alpha - sqrt}"
    end

end

def execute(str)
    
    exponent = -> (dt) { if dt["x_2"].nil? && dt["x_1"].nil? then 0 elsif dt["x_2"].nil? then 1 else 2 end }
    functions = [method(:solve_c), method(:solve_linear), method(:solve_second_degree)]

    normalized_equation = lexer(str)
    datastruct = parser(normalized_equation)
    degree = exponent.call(datastruct)
    print_minimized_and_degree(datastruct, degree)
    functions[degree].call(datastruct)

end

def main

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