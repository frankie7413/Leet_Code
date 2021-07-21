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
    puts 'Passed'
  else
    puts "Failed: #{input} != #{output}"
  end
end

# test_case("3[a]2[bc]", "aaabcbc")
# test_case("3[ a2[ c ] ]", "acc acc acc")
# cc
# 2 * cc
# 3 * ( a + ( 2 * cc ) )
#def decode_string(s)
#  return s unless s.include?('[')
#
#  puts "Initial: #{s}"
#  first_bracket = s.index('[')
#  second_bracket = if s[(first_bracket + 1)..s.size].include?('[')
#                     s.rindex(']')
#                   else
#                     s = s.delete(']')
#                     s.size
#                   end
#
#  result = s[(first_bracket + 1)..second_bracket]
#
#  prefix = if result.include?('[') && result.count(']') == 2
#             puts result
#             result[0..(result.index('[') - 1)].gsub(/\d+/, '')
#           else
#             ''
#           end
#  puts "Final Result: #{result}"
#  puts "prefix: #{prefix}"
#
#  (prefix + decode_string(result)) * s[first_bracket - 1].to_i
#end

def decode_string(s)
  return s unless s.include?('[')

  puts "Initial: #{s}"

  # assuming no other brackets
  first_bracket = s.index('[')
  second_bracket = s.index(']')

  result = s[(first_bracket + 1)..(second_bracket - 1)]

  puts "Final Result: #{result}"


  prefix = (first_bracket - 1).zero? ? '' : s[0..first_bracket].gsub(/\d+|\[|\]/, '')
  prefix + result * s[first_bracket - 1].to_i + decode_string(s[(second_bracket + 1)..s.size])
end

# Example 1
test_case("3[a]2[bc]", "aaabcbc")

# Example 2
# test_case("3[a2[c]]", "accaccacc")

# Example 3
test_case("2[abc]3[cd]ef", "abcabccdcdcdef")

# Example 4
test_case("abc3[cd]xyz", "abccdcdcdxyz")
