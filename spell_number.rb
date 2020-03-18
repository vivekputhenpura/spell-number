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

        
        file_name = "dictionary.txt"
        file_path = File.join(File.dirname(__FILE__), file_name)
        $dictionary = File.read(file_path).split

        characters = {
            '2' => ['A', 'B', 'C'],
            '3' => ['D', 'E', 'F'],
            '4' => ['G', 'H', 'I'],
            '5' => ['J', 'K', 'L'],
            '6' => ['M', 'N', 'O'],
            '7' => ['P', 'Q', 'R', 'S'],
            '8' => ['T', 'U', 'V'],
            '9' => ['W', 'X', 'Y', 'Z'],
        }
            
        # char_map = number.chars.map{|digit|characters[digit]}
        
        pattern = number.chars.map{|digit|"("+characters[digit].join("|")+")"}
        pattern = pattern.join("")
        pattern = /^#{pattern}$/
        
        words = $dictionary.grep(pattern)
    
        pattern = number[0,3].chars.map{|digit|"("+characters[digit].join("|")+")"}
        pattern = pattern.join("")
        pattern = /^#{pattern}$/           
        
        words2 = $dictionary.grep(pattern)

        comb = words + words2

        return comb
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
end
print SpellNumbers.new.to_words('6686787825')