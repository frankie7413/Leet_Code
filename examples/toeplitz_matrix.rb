# https://leetcode.com/problems/toeplitz-matrix/
# Given an m x n matrix, return true if the matrix is Toeplitz. Otherwise, return false.
# A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.

# Input: matrix = [[1,2,3,4],[5,1,2,3],[9,5,1,2]]
# Output: true
# Explanation:
# In the above grid, the diagonals are:
# "[9]", "[5, 5]", "[1, 1, 1]", "[2, 2, 2]", "[3, 3]", "[4]".
# In each diagonal all elements are the same, so the answer is True.

def test_case(input, output)
  input = is_toeplitz_matrix?(input)
  if input == output
    puts "Passed"
  else
    puts "Failed: #{input} != #{output}"
  end
end

# visualization to spot solution approach
# [[1,2,3,4],
#  [5,1,2,3],
#  [9,5,1,2]]
def is_toeplitz_matrix?(matrix)
  return false if matrix.first.include?(matrix.last.first) || matrix.last.include?(matrix.first.last)

  matrix.each_with_index do |row, index|
    location = index
    row.each_with_index do |element, index|
      next if location == matrix.size - 1 || row.last == element

      return false unless matrix[location + 1][index + 1] == element
    end
  end

  true
end

# Example 1
matrix = [[1,2,3,4],[5,1,2,3],[9,5,1,2]]
test_case(matrix, true)

# Example 2
matrix = [[1,2],[2,2]]
test_case(matrix, false)

# Example 3
matrix = [[1,2,3,4,6],[5,1,2,3,4],[9,5,1,2,3],[11, 9, 5, 1, 2]]
test_case(matrix, true)
