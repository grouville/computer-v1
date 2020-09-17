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
    
    # minimized_equation = { x_2: 0, x_1: 0, x_0: 0 }
    
    #DEBUG puts "e: |#{e}|"
    # puts "\n------DEBUG-EL----"
    # print elements
    # puts "\n------DEBUG-----"

    # Array that will contain the 2d arrays of parsed data
    array_hash_2d = elements.map.with_index { |el, i|
        
        tmp_hash = {}
        el.each { |e|

            # Check that the letter X is present
            raise("Put an X variable my dear") unless e.match?(/\*X\^/)
            # Check that the multiplier is a number
            raise("Put a real int please") if e.match(/^((?:|[+-])\d*)\*/).nil?
            # Check that the exponent is a number
            raise("Put a real exponent please") if e.match(/\^((?:|[+-])\d*)$/).nil?

            # Create hash + collect exponent and slope coefficient
            exponent = e.split("^")[1].to_i
            slope_coeff = e.split("*")[0].to_i
            tmp_hash["x_#{exponent}"] = slope_coeff

        }

        tmp_hash
    }

    minimized_equation = Hash.new(0)
    puts "\n----------DG-----\n"
    array_hash_2d[0].each { |key, value| minimized_equation[key] += value }
    array_hash_2d[1].each { |key, value| minimized_equation[key] -= value }

    minimized_equation = minimized_equation.filter {|key, value| value != 0 }

    print minimized_equation
    # puts "\n----------DEBBBUUUUUGGG-FLAT-----\n"
    
    # print array_hash_2d


        # Array containing the hashes of all str
        # array_hash = []
        # puts "\n------EL-----"

        # el.each do | str |
            
        #     # if 

        #     # Regex on str
        #     puts str

        # end

        # Add element into array
        # array_hash_2d << array_hash

    # Check that elements of the Array contains an "X"
    # raise("Sign next to exponent") if !filtered_parts.all? { | el | el.all? { | e | e.include? "X" } }
end

def execute(str)

    normalized_equation = lexer(str)
    datastruct = parser(normalized_equation)

end

def main()

    print("Enter your input: ")
    str = gets.chomp
    # begin
        execute(str)
    # rescue => e
    #     puts "\nError: \"#{e}\""
    #     exit 1
    # end

end

main()