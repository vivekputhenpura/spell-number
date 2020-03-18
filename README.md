# spell-number
Converts phone number to words to make it easier to remember.

spell-number is a ruby library to convert 10 digit numbers to human readable words or combination of words.

The input should be a 10 digit number. Input should not contain 0 or 1. spell-number will return words/combination of words having at least 3 characters.

## Installation

Download the directory and extract to your project folder. For ROR projects, you can place it in vendor/

## Usage

```ruby
require "spellnumber/spell_number"

SpellNumbers.new.to_words('2222555564') # returns array of words/combination of words like ["motortruck", "motor, truck"]
SpellNumbers.new.to_words('string') # returns {status: "error", code: "invalid number", message: "input should be a 10 digit number and should not contain 0 or 1"}
