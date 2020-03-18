# Converts 10 digit number to words
class SpellNumbers
    # Public method to call the library methods
    # Accepts 10 digit number.
    # @param [String] number
    # @return [Array]
    def to_words(number)        
        words = convert(number) # call the original convert method

        return words
    end

    private

    # @method conver does the actual conversion
    # @param [String] number
    # @return [Array]
    def convert(number)
        # validate the parameter
        return validate(number) if validate(number) != true

        # read the dictionary file contents to a global variable to use in different functions
        file_name = "dictionary.txt"
        file_path = File.join(File.dirname(__FILE__), file_name)
        $dictionary = File.read(file_path).split        
            
        combinationmodel = [
            [3, 3, 4],
            [3, 4, 3],
            [3, 7],
            [4, 3, 3],
            [4, 6],
            [5, 5],
            [6, 4],
            [7, 3]
          ]
        combinations = get_words(number)

        for model in combinationmodel
            comb_array = []
            start = 0;
            for count in model
                split = number[start,count]
                words = get_words(split)
                
                if words.nil?
                    comb_array = []
                    break
                end
                
                print words,comb_array,"\n.....\n"
                
                comb_array << words
                start = start + count
            end

            comb_array
        end    
        return comb_array
    end

    # Validate the input param
    # @param [String] number
    # @return [Boolean] true if valid number
    # @return [Object] if invalid number
    def validate(number)
        error = {
            status: "error", 
            code: "invalid number", 
            message: "input should be a 10 digit number and should not contain 0 or 1"
        }

        # check input is not null, is a number and not contains 0 or 1
        return error if number.nil? || 
                        number.length != 10 || 
                        number.split('').select{
                            |a|(a.to_i == 0 || a.to_i == 1)
                        }.length > 0

        return true
    end

    def get_words(number)
        #number to letters mapping
        letters = {
          '2' => ['A', 'B', 'C'],
          '3' => ['D', 'E', 'F'],
          '4' => ['G', 'H', 'I'],
          '5' => ['J', 'K', 'L'],
          '6' => ['M', 'N', 'O'],
          '7' => ['P', 'Q', 'R', 'S'],
          '8' => ['T', 'U', 'V'],
          '9' => ['W', 'X', 'Y', 'Z'],
        }
        
    
        pattern = number.chars.map{|digit|"("+letters[digit].join("|")+")"}
        pattern = pattern.join("")
        pattern = /^#{pattern}$/

        print pattern,"\n.....\n"
        
        words = $dictionary.grep(pattern)
        return words
    end
end
print SpellNumbers.new.to_words('6686787825')