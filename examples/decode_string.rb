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
  stack = []

  s.each_char do |c|
    if c == ']'
      puts stack.join
      s1 = ''
      while stack.last != '['
        s1 = stack.pop + s1
      end
      stack.pop # remove '['
      n = ''
      while !stack.empty? && stack.last.match?(/[0-9]/) # eg. "100[leetcode]"
        n = stack.pop + n
      end
      stack.push(s1 * n.to_i)
    else
      stack.push(c)
    end
  end

  stack.join
end

# Example 1
# test_case("3[a]2[bc]", "aaabcbc")

# Example 2
test_case("3[a2[c]]", "accaccacc")

# Example 3
# test_case("2[abc]3[cd]ef", "abcabccdcdcdef")

# Example 4
# test_case("abc3[cd]xyz", "abccdcdcdxyz")

# Example 5 with string after inner brackets
# test_case("3[a2[c]xyz]", "accxyzaccxyzaccxyz")

# Example 6
# test_case("100[leetcode]", "leetcode" * 100)

