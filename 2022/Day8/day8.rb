require 'matrix'
require 'set'

input = File.read("input.txt")

matrix = Matrix.rows([])

input.split("\n").each do |row|
    matrix = Matrix.rows(matrix.to_a << row.split(""))
end

def get_scenic_score (start, rest_in_line)
    print(start, " ", rest_in_line, "\n")
    if rest_in_line.empty?
        return 0
    end
    score = 0
    for current_tree in rest_in_line
        score += 1
        if current_tree >= start
            break
        end
    end
    return score
end

# puts get_scenic_score(4, [3,1,1,1,3,2,1,2,3,3,1,2,4,1,2,1,1,4,7,8,9])

scenic_scores = []

visible_tree_count = 0
for row_num in 0..matrix.to_a.length() - 1
    row = matrix.to_a[row_num]
    for col_num in 0..row.length() - 1
        tree = matrix.to_a[row_num][col_num]
        tree_visible = false

        left, *rest_to_right = matrix.to_a[row_num].map(&:to_i).slice(col_num, row.length())
        left_score = get_scenic_score(left, rest_to_right)
        *rest_to_left, right = matrix.to_a[row_num].map(&:to_i).slice(0, col_num + 1)
        right_score = get_scenic_score(right, rest_to_left.reverse())
        top, *rest_below = matrix.column(col_num).to_a.map(&:to_i).slice(row_num, row.length())
        top_score = get_scenic_score(top, rest_below)
        *rest_above, below = matrix.column(col_num).to_a.map(&:to_i).slice(0, row_num + 1)
        below_score = get_scenic_score(below, rest_above.reverse())

        score = left_score * right_score * top_score * below_score
        scenic_scores.push(score)
        
        if rest_to_right.empty? || left > rest_to_right.max()
            # can see from right
            tree_visible = true
        elsif rest_to_left.empty? || right > rest_to_left.max()
            # can see from left
            tree_visible = true
        elsif rest_below.empty? || top > rest_below.max()
            # can see from below
            tree_visible = true
        elsif rest_above.empty? || below > rest_above.max()
            # can see from above
            tree_visible = true
        end
        if tree_visible
            visible_tree_count += 1
        end
    end
end

# puts visible_tree_count
puts scenic_scores.max()
