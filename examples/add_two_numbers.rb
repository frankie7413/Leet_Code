# frozen_string_literal: true

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
  dict = {}
  # key -> value  target - num = key
  # 2 -> 0        9 - 2 = 7
  # 7 -> 1        9 - 7 = 2 <- found exit
  # 11 -> 2
  # 15 -> 3
  nums.each_with_index do |num, index|
    return puts "#{dict[target - num]}, #{index}" if dict[target - num]

    dict[num] = index
  end
end

# Example 1:
# Input: nums = [2,7,11,15], target = 9
# Output: [0,1]
# Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

nums = [2, 7, 11, 15]
target = 9
two_sum(nums, target)

# Example 2:
# Input: nums = [3,2,4], target = 6
# Output: [1,2]

nums = [3, 2, 4]
target = 6
two_sum(nums, target)

# Example 3:
# Input: nums = [3,3], target = 6
# Output: [0,1]
nums = [3, 3]
target = 6
two_sum(nums, target)
