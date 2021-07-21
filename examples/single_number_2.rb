# Given an integer array nums where every element appears three times except for one,
# which appears exactly once. Find the single element and return it.

# You must implement a solution with a linear runtime complexity and use only constant extra space.

# Constraints:
# 1 <= nums.length <= 3 * 104
# -231 <= nums[i] <= 231 - 1
# Each element in nums appears exactly three times except for one element which appears once.

def test_case(input, output)
  if input == output
    puts 'Passed'
  else
    puts "Failed: #{input} != #{output}"
  end
end

def single_number(nums)
  h = {}

  nums.each do |num|
    if h.key?(num.to_s)
      h[num.to_s] += 1
   else
      h[num.to_s] = 1
    end
  end

  return h.key(1).to_f
end

# alternative
# use .count to return element that has count equal to 1
# learn more ruby array methods doh!
# def single_number(nums)
#   nums.each do |num|
#     return num if nums.count(num) == 1
#   end
# end

puts 'Example 1: '
nums = [2,2,3,2]
test_case(single_number(nums), 3)

puts 'Example 2: '
nums = [0,1,0,1,0,1,99]
test_case(single_number(nums), 99)
