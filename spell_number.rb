# Converts 10 digit number to words
class SpellNumbers
    # Public method to call the library method
    # @param [String/Integer] number
    # @return [Array] on success
    #   example: ["motortruck", "motor, truck"]
    # @return [Object] on failure
    #   example: {
    #       status: "error", 
    #       code: "invalid number", 
    #       message: "input should be a 10 digit number and should not contain #       0 or 1"
    #   }
    def to_words(number)
        words = convert(number.to_s) # call the original convert method

        return words
    end

    private

    # @method Convert does the actual conversion
    # @param [String] number
    # @return [Array] on success
    # @return [Object] on failure
    def convert(number)
        # validate the parameter
        return validate(number) if validate(number) != true

        combinations = []
        $array_map = {}

        # read the dictionary file contents to a global variable to use in different functions
        file_name = "dictionary.txt"
        file_path = File.join(File.dirname(__FILE__), file_name)
        $dictionary = File.read(file_path).split

        # get the alphabetic characters corresponding to the given number
        char_map = get_chars_for_number(number)

        combinationmodel = get_combination_model()

        combinationmodel.each do |model|
            word_array = []
            start = 0;
            
            # split the whole number in to chunks using the model
            # each chunk have minimum 3 digits so that the words are at least 3 characters long
            # loop though the chunks and get the words for each chunk
            model.each_with_index do |count, index|
                split = number[start, count]
                char_array = char_map[start, count] # corresponding characters for the split number
                
                words = get_words(split, char_array)

                # if any chunk is not returning words from the dictionary, leave the combination
                if words.nil?
                    word_array = []
                    break
                end
                
                # the array of words for the split numbers
                word_array << words
                start = start + count
            end
            
            # create different combination of words from the array of words for each chunk
            if word_array.length > 0
              tempCombinations = get_word_combinations(word_array)
              combinations = combinations + tempCombinations
            end
        end

        return combinations # final output
    end

    # Validate the input parameter
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

    # Returns the corresponding characters for given number
    # @param [String] number
    # @return [Array[Array]] like [['A', 'B', 'C'], ['M', 'N', 'O']] 
    def get_chars_for_number(number)
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
        
        return number.chars.map{|digit|characters[digit]}
    end

    # Returns the array of combinations of number of digits by which the whole number can be split in to. Each chunk should be having at least 3 digits.
    def get_combination_model
        return [
            [10],
            [3, 3, 4],
            [3, 4, 3],
            [3, 7],
            [4, 3, 3],
            [4, 6],
            [5, 5],
            [6, 4],
            [7, 3]
        ];
    end

    # Get the words from the dictionary
    # @param [String] number
    # @param [Array] char_array array of characters for the number
    # @return [Array] array of words
    def get_words(number, char_array)
        # check if the words are already found before
        if !$array_map[number].nil?
          return $array_map[number]
        end
        
        # if no words already found for the number, 
        # generate all possible words using the array of characters for each digit
        possible_words = char_array.first.product(*char_array[1..-1]).map(&:join)
        words = possible_words & $dictionary # lookup the generated words in the dictionary
        $array_map[number] = words # store in a global variable to use next time
        
        return words
    end

    # Combine the array of words to populate different combination of words
    # @param [Array] array two dimentional array of words for the chunks in a number
    # @retun [Array]
    def get_word_combinations(array)
        words = []
        array.first.product(*array[1..-1]).each do |word|
          words << word.join(",")
        end
    
        return words
    end
end