require "test/unit"
require_relative "../spell_number"

class TestCase < Test::Unit::TestCase

	def test_validation
		expected = SpellNumbers.new.to_words("number")
		assert_equal(expected[:status], "error")
	end

	def test_conversion_return_type
		expected = SpellNumbers.new.to_words("6686787825")
		assert_equal(expected.class, Array)
	end

	def test_conversion
		expected = SpellNumbers.new.to_words("6686787825")
		assert_equal(expected.include?("MOT,OPT,PUCK"), true)
	end

end	
