# Missing Number:
# 
# Question:
# An array is supposed to have n+1 uniq unsorted numbers e.g.[0,1,2..n]
# But there are only n numbers in it. Find the missing one.
# 
# Verification:Missing Number:

# n size 
# [0,1,3]

# The total should be n + 1 size therefore make array with range 0 to n to meet
# n + 1 size requirement and difference for problem.
# [0,1,2,3]


# using math
# 1 + 2 + ... + n = n * (n - 1) / 2
# def find_missing_num(array)
#   array.size*(array.size + 1)/2  - array.sum
# end

# ruby simple one liner
def find_missing_num(array)
  ((0..array.size).to_a - array).first
end

# Verification:

def test_case(array, answer) 
  found = find_missing_num(array) 
  return puts 'Success' if found == answer

  puts "Failed at: #{array} with expected return: #{answer}"
end

test_case([0,1,3], 2) #returns 2
test_case([3,2,1], 0) #returns 0
test_case([2,1,0], 3) #returns 3
test_case([4,2,3,5,0], 1) #returns 1
