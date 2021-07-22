# Given an encoded string, return its decoded string.

# The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being repeated exactly k times. Note that k is guaranteed to be a positive integer.
# You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.
# Furthermore, you may assume that the original data does not contain any digits and that digits are only for those repeat numbers, k. For example, there won't be input like 3a or 2[4].

# Constraints:
# 1 <= s.length <= 30
# s consists of lowercase English letters, digits, and square brackets '[]'.
# s is guaranteed to be a valid input.
# All the integers in s are in the range [1, 300].

def test_case(input, output)
  input = decode_string(input)
  if input == output
    puts "Passed"
  else
    puts "Failed: #{input} != #{output}"
  end
end

# test_case("3[a]2[bc]", "aaabcbc")
# test_case("3[ a2[ c ] ]", "acc acc acc")
# cc
# 2 * cc
# 3 * ( a + ( 2 * cc ) )
# Recusion solution with edge case for strings with inner brackets
def decode_string(s)
  return s unless s.include?('[')

  inner_bracket = false
  first_bracket = s.index('[')
  second_bracket = s.index(']')

  if s[(first_bracket + 1)..(second_bracket - 1)].include?('[')
    inner_bracket = true
    second_bracket = s.rindex(']')
  end

  result = s[(first_bracket + 1)..(second_bracket - 1)]
  # use regex to remove any brackets or digits
  prefix = (first_bracket - 1).zero? ? '' : s[0..first_bracket].gsub(/\d+|\[|\]/, '')
  if inner_bracket
    (prefix + decode_string(result)) * s[first_bracket - 1].to_i
  else
    prefix + result * s[first_bracket - 1].to_i + decode_string(s[(second_bracket + 1)..s.size])
  end
end

# Example 1
test_case("3[a]2[bc]", "aaabcbc")

# Example 2
test_case("3[a2[c]]", "accaccacc")

# Example 3
test_case("2[abc]3[cd]ef", "abcabccdcdcdef")

# Example 4
test_case("abc3[cd]xyz", "abccdcdcdxyz")

# Example 5 with string after inner brackets
test_case("3[a2[c]xyz]", "accxyzaccxyzaccxyz")
