def test_case(input, output)
  input = first_missing_positive(input)
  if input == output
    puts "Passed"
  else
    puts "Failed: #{input} != #{output}"
  end
end

def first_missing_positive(nums)
  return 1 if nums.size == 0

  length = nums.size
  nums = nums.select(&:positive?)

  return nums + 1 if nums.size == 1
  missing = (nums.min..nums.max).to_a - nums

  return length if missing.empty?
  return 1 if missing.first > nums.min && nums.min != 1

  missing.first
end

def first_missing_positive(nums)
  length = nums.length

  (0...length).each do |i|
    while (nums[i] > 0) && (nums[i] <= length) && (nums[nums[i] - 1] != nums[i])
      nums[nums[i]-1], nums[i] = nums[i], nums[nums[i]-1]
    end
  end

  nums.each_with_index do |num, index|
    return index + 1 unless num == index + 1
  end

  length + 1
end


# Example 1
test_case([1,2,0], 3)

# Example 2
test_case([3,4,-1,1], 2)

# Example 3
test_case([7,8,9,11,12], 1)

# Example 4
test_case([11,12,14], 1)

# Example 5
test_case([1,2,4,0], 3)

# Example 6
test_case([0], 1)
