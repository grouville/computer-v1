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
                raise("Please put an X variable") unless e.match?(/\*X\^/)
                # Check that the multiplier is an int (or a float)
                raise("Please put a real int please") if e.match(/^((?:|[+-])(\d+(\.\d+)?))\*/).nil?
                # Check that the exponent is an int
                raise("Please put a valid format of exponent") if e.match(/\^-?\d+$/).nil?

                # Create hash + collect exponent and slope coefficient
                exponent = e.match(/\^-?\d+$/)[0][1..].to_i
                slope_coeff = e.split("*")[0].to_f

                # Add similar keys together, or create when new
                if tmp_hash[exponent].nil?
                    tmp_hash[exponent] = slope_coeff else tmp_hash[exponent] += slope_coeff end
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

    return minimized_equation
end

def print_minimized_and_degree(datastruct)

    exponent = -> (dt) { if dt.nil? || dt.length == 0 then 0 else datastruct.keys.max.ceil end }
    l = -> (number) { a = if number >= 0 then " + " else " - " end ; return a }
    l_max = -> (number) { a = if number >= 0 then "" else "-" end ; return a }
    c = -> (number) { a = if number < 0 then number * -1 else number end ; return a }
    print_x = -> (el) { if el == 1 then "x" elsif el == 2 then "x²" else "x^#{el.ceil}" end }
    
    degree = exponent.call(datastruct)
    max_key = datastruct.keys.max
    min_key = datastruct.keys.min
    cpy_dt = datastruct.clone
    datastruct.delete(0)
    max_key2 = datastruct.keys.max
    keys = datastruct.keys.sort.reverse

    str = "\nThe reduced form is : "
    keys.each do | el |
            str += (el == max_key2) ? l_max.call(datastruct[el]) : l.call(datastruct[el])
            str += "#{c.call(datastruct[el].round(5))}"
            str += if el != 0 then print_x.call(el) else "" end 
    end
    if !cpy_dt[0].nil? then
        str += (0 == max_key && min_key >= 0) ? l_max.call(cpy_dt[0]) : l.call(cpy_dt[0])
        str += "#{c.call(cpy_dt[0].round(5))}"
    end
    str += "0" if max_key.nil?
    str += " = 0"
    puts str

    raise("Put a valid exponent please (valid polynomial degree)") if degree > 2 || (!min_key.nil? && min_key < 0)
    puts "Polynomial degree: #{degree}"
    
    return cpy_dt
end

def solve_c(datastruct)

    if datastruct[0].nil? then
    puts "All Real numbers are valid" else puts "No solution possible" end

end
  
def solve_linear(datastruct)

    b = datastruct[1]
    c = if datastruct[0].nil? then 0 else datastruct[0] end
    puts "The solution is : #{(-c/b).round(5)}"

end

def solve_second_degree(datastruct)

    my_sqrt = -> (nb) { i = 0.00001; while (i*i) < nb do i += 0.00001 end ; return i.to_f().round(5) }
    discriminant = -> (a,b,c) { b*b - 4*a*c }
    getter = -> (dt, key) { if dt[key].nil? then 0 else dt[key] end }
    
    a = datastruct[2]
    b = getter.call(datastruct, 1)
    c = getter.call(datastruct, 0)
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
    
    degree = -> (dt) { if dt[2].nil? && dt[1].nil? then 0 elsif dt[2].nil? then 1 else 2 end }
    functions = [method(:solve_c), method(:solve_linear), method(:solve_second_degree)]

    normalized_equation = lexer(str)
    datastruct = parser(normalized_equation)
    datastruct = print_minimized_and_degree(datastruct)
    functions[degree.call(datastruct)].call(datastruct)

end

def main

    print("Enter your input: ")
    str = gets.chomp
    begin
        execute(str)
    rescue => e
        puts "Error: \"#{e}\""
        # puts e.backtrace 
        exit 1
    end

end

main()