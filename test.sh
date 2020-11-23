RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BOUM='\033[0;34m'
INFOS='\033[0;35m'
NC='\033[0m' # No color

##### Successfull tests #####
echo -e "${GREEN}SUCCESSFULL TESTS: ${NC}"; echo "";

    ### Title
    echo -e "${INFOS}Degree 0: No solution: ${NC}"; echo "";
    # Degree 0: No solution
    echo -e "-1 * X^3  = -0.2 * X^0 - 1 * X^3 :" ;
    echo -e "-1 * X^3  = -0.2 * X^0 - 1 * X^3" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^1  = -1 * X^1 :" ;
    echo -e "-1 * X^1  = -1 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^11  = -1 * X^11 :" ;
    echo -e "-1 * X^11  = -1 * X^11" | ruby cv1.rb;
    echo "";

    echo -e "-0.0 * X^1 - +0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1 :" ;
    echo -e "-0.0 * X^1 - +0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^3  = -0.2 * X^0 - 1 * X^3 :" ;
    echo -e "-1 * X^3  = -0.2 * X^0 - 1 * X^3" | ruby cv1.rb;
    echo "";

    ### Title
    echo -e "${INFOS}Degree 1: 1 solution: ${NC}"; echo "";
    ## Degree 1: 1 solution
    echo -e "1 * X^1 -  -4 * X^1 - -4 * X^0 = -1 * X^0 + +1 * X^0 + -5 * X^0 :" ;
    echo -e "1 * X^1 -  -4 * X^1 - -4 * X^0 = -1 * X^0 + +1 * X^0 + -5 * X^0" | ruby cv1.rb;
    echo "";

    echo -e "-0.2 * X^1 +  -0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.1 * X^1 :" ;
    echo -e "-0.2 * X^1 +  -0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.1 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "-0.2 * X^1 - +0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.1 * X^1 :" ;
    echo -e "-0.2 * X^1 - +0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.1 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^1  = -0.2 * X^0 :" ;
    echo -e "-1 * X^1  = -0.2 * X^0" | ruby cv1.rb;
    echo "";

    ### Title
    echo -e "${INFOS}Degree 2: # Delta > 0: ${NC}"; echo "";
    # Delta > 0
    echo -e "-1.0 * X^---1 - +2 * X^2 = -1.0 * X^---1 + -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1 :" ;
    echo -e "-1.0 * X^---1 - +2 * X^2 = -1.0 * X^---1 + -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "-1.0 * X^----1 - +2 * X^2 = -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1 :" ;
    echo -e "-1.0 * X^----1 - +2 * X^2 = -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1" | ruby cv1.rb;
    echo "";

    ### Title
    echo -e "${INFOS}Degree 2: # Delta == 0: ${NC}"; echo "";
    # Delta == 0

    ### Title
    echo -e "${INFOS}Degree 2: # Delta < 0: ${NC}"; echo "";
    # Delta < 0


##### Incorrect input with good formatting #####
echo -e "${ORANGE}INCORRECT INPUT WITH GOOD FORMATTING${NC}"; echo "";

    ### Title
    echo -e "${INFOS}Incorrect :  Exponent > 2: ${NC}"; echo "";
    # Exponent > 2
    echo -e "-1 * X^11  = 1 * X^11 :" ;
    echo -e "-1 * X^11  = 1 * X^11" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^3  = -0.2 * X^0 :" ;
    echo -e "-1 * X^3  = -0.2 * X^0" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^4  = -0.2 * X^0 - 1 * X^3 :" ;
    echo -e "-1 * X^4  = -0.2 * X^0 - 1 * X^3" | ruby cv1.rb;
    echo "";

    echo -e "1 * X^11 + 1 * X^2  =  1 * X^0 :" ;
    echo -e "1 * X^11 + 1 * X^2  =  1 * X^0" | ruby cv1.rb;
    echo "";


    ### Title
    echo -e "${INFOS}Incorrect :  Exponent < 0: ${NC}"; echo "";
    # Exponent < 0
    echo -e "-1 * X^-2  = -0.2 * X^0 :" ;
    echo -e "-1 * X^-2  = -0.2 * X^0" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^-1  = -0.2 * X^0 :" ;
    echo -e "-1 * X^-1  = -0.2 * X^0" | ruby cv1.rb;
    echo "";


    ### Title
    echo -e "${INFOS}Incorrect : Both < 0: ${NC}"; echo "";
    # Both
    echo -e "-1 * X^-2  = -0.2 * X^0 - 1 * X^3 :" ;
    echo -e "-1 * X^-2  = -0.2 * X^0 - 1 * X^3" | ruby cv1.rb;
    echo "";

 
##### Wrong format errors #####
echo -e "${RED}WRONG FORMAT ERRORS ${NC}"; echo "";

    ### Title
    echo -e "${INFOS}W_Format : + Sign: ${NC}"; echo "";
    # + Sign
    echo -e "-0.0 * X^+1 - +0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1 :" ;
    echo -e "-0.0 * X^+1 - +0 * X^0 = -0.2 * X^0 - 0.1 * X^0 -  0.0 * X^1" | ruby cv1.rb;
    echo "";


    ### Title
    echo -e "${INFOS}W_Format : Letters: ${NC}"; echo "";
    # Letters
    echo -e "-1 * X^B = -0.2 * X^0 :" ;
    echo -e "-1 * X^B = -0.2 * X^0" | ruby cv1.rb;
    echo "";

    echo -e "-1 * B^1 = -0.2 * X^0 :" ;
    echo -e "-1 * B^1 = -0.2 * X^0" | ruby cv1.rb;
    echo "";


    ### Title
    echo -e "${INFOS}W_Format : Float exponents: ${NC}"; echo "";
    # Float exponents:
    echo -e "-1 * X^2.0 = -0.2 * X^0 :" ;
    echo -e "-1 * X^2.0 = -0.2 * X^0" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^3.00 = -0.2 * X^0 - 1 * X^3 :" ;
    echo -e "-1 * X^3.00 = -0.2 * X^0 - 1 * X^3" | ruby cv1.rb;
    echo "";

    echo -e "-1 * X^3.23 = -0.2 * X^0 - 1 * X^3:" ;
    echo -e "-1 * X^3.23 = -0.2 * X^0 - 1 * X^3" | ruby cv1.rb;
    echo "";


    ### Title
    echo -e "${INFOS}W_Format : {NB} * X^{EXPONENT}: ${NC}"; echo "";
    # Doesn't respect the directions : {NB} * X^{EXPONENT}
    echo -e "X+2=0:" ;
    echo -e "X+2=0" | ruby cv1.rb;
    echo "";

    echo -e "X + 2=0:" ;
    echo -e "X + 2=0" | ruby cv1.rb;
    echo "";

    echo -e "2X + 2=0:" ;
    echo -e "2X + 2=0" | ruby cv1.rb;
    echo "";

    echo -e "2X^2 + 2=0:" ;
    echo -e "2X^2 + 2=0" | ruby cv1.rb;
    echo "";

    echo -e "2X^2 + 4X^1 + 2=0:" ;
    echo -e "2X^2 + 4X^1 + 2=0" | ruby cv1.rb;
    echo "";

    echo -e "-2X^2 + 4X^1 + 2=0:" ;
    echo -e "-2X^2 + 4X^1 + 2=0" | ruby cv1.rb;
    echo "";

    echo -e "X^2 + 1X^1 + 2=0:" ;
    echo -e "X^2 + 1X^1 + 2=0" | ruby cv1.rb;
    echo "";

# Interesting comparisons
echo -e "${BOUM}Interesting comparisons${NC}"; echo "";
    
    ### Title
    echo -e "${INFOS}Advanced tests : Evolution: ${NC}"; echo "";
    # Interesting cases
    echo -e "1 * X^-0  = 1 * X^1:" ;
    echo -e "1 * X^-0  = 1 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "1 * X^0  = 1 * X^1:" ;
    echo -e "1 * X^0  = 1 * X^1" | ruby cv1.rb;
    echo "";

    echo -e "1 * X^-15  = 1 * X^-15:" ;
    echo -e "1 * X^-15  = 1 * X^-15" | ruby cv1.rb;
    echo "";

    echo -e "1 * X^-15 + 1 * X^0 = 1 * X^-15 - 5 * X^2:" ;
    echo -e "1 * X^-15 + 1 * X^0 = 1 * X^-15 - 5 * X^2" | ruby cv1.rb;
    echo "";

    echo -e "1 * X^-15 - -2 * X^1 + 1 * X^0 = 1 * X^-15 - 5 * X^2:" ;
    echo -e "1 * X^-15 - -2 * X^1 + 1 * X^0 = 1 * X^-15 - 5 * X^2" | ruby cv1.rb;
    echo "";

    echo -e "1 * X^-1 - -2 * X^1 + 1 * X^0 = 1 * X^-15 - 5 * X^2:" ;
    echo -e "1 * X^-1 - -2 * X^1 + 1 * X^0 = 1 * X^-15 - 5 * X^2" | ruby cv1.rb;
    echo "";
