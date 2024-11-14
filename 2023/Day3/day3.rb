require 'matrix'

def get_number_from_line(start, line)
    number_buffer = []
    number_buffer.push(line[start])
    for x in (start - 1).downto(0)
        if line[x].match(/^(\d)+$/)
            number_buffer.prepend(line[x])
        else
            break
        end
    end
    for x in (start + 1)...line.size()
        if line[x].match(/^(\d)+$/)
            number_buffer.push(line[x])
        else
            break
        end
    end
    return number_buffer.join.to_i
end

input = File.read("input.txt")
grid = Matrix.rows([])
input.split("\n").each do |row|
    grid = Matrix.rows(grid.to_a << row.split(""))
end

column_count = grid.column_count()
row_count = grid.row_count()
characters = ["@", "#", "$", "%", "&", "*", "-", "+", "=", "/"]
part_numbers = []
has_special_adjacent = false
number_buffer = []
gear_ratios = []

for x in 0...column_count
    if has_special_adjacent
        part_numbers.push(number_buffer.join.to_i)
        number_buffer = []
    end
    has_special_adjacent = false
    for y in 0...row_count
        adjacent_chars = []
        is_digit = grid[x, y].match(/^(\d)+$/)
        is_gear = grid[x, y] == "*"
        
        if is_digit
            number_buffer.push(grid[x, y])
            if x > 0
                top_char = grid[x - 1, y]
                adjacent_chars.push(top_char)
                top_right_char = grid[x - 1, y + 1]
                adjacent_chars.push(top_right_char)
                if y > 0
                    top_left_char = grid[x - 1, y - 1]
                    adjacent_chars.push(top_left_char)
                end
            end
            right_char = grid[x, y + 1]
            adjacent_chars.push(right_char)
            bottom_right_char = grid[x + 1, y + 1]
            adjacent_chars.push(bottom_right_char)
            bottom_char = grid[x + 1, y]
            adjacent_chars.push(bottom_char)
            if y > 0
                bottom_left_char = grid[x + 1, y - 1]
                adjacent_chars.push(bottom_left_char)
                left_char = grid[x, y - 1]
                adjacent_chars.push(left_char)
            end
            if (characters & adjacent_chars).any?
                has_special_adjacent = true
            end
        else
            if has_special_adjacent
                part_numbers.push(number_buffer.join.to_i)
                has_special_adjacent = false
            end
            number_buffer = []
        end
        
        if is_gear
            part_number_pair = []
            if x > 0
                top_row_matches = []
                top_char = grid[x - 1, y]
                if top_char.match(/^(\d)+$/)
                    top_row_matches.push(get_number_from_line(y, grid.row(x - 1)))
                end
                top_right_char = grid[x - 1, y + 1]
                if top_right_char.match(/^(\d)+$/)
                    top_row_matches.push(get_number_from_line(y + 1, grid.row(x - 1)))
                end
                if y > 0
                    top_left_char = grid[x - 1, y - 1]
                    if top_left_char.match(/^(\d)+$/)
                        top_row_matches.push(get_number_from_line(y - 1, grid.row(x - 1)))
                    end
                end
                if top_row_matches.size() == 3
                    top_row_matches = top_row_matches.uniq
                end
                part_number_pair.push(*top_row_matches)
            end
            right_char = grid[x, y + 1]
            if right_char.match(/^(\d)+$/)
                part_number_pair.push(get_number_from_line(y + 1, grid.row(x)))
            end
            bottom_row_matches = []
            bottom_right_char = grid[x + 1, y + 1]
            if bottom_right_char.match(/^(\d)+$/)
                bottom_row_matches.push(get_number_from_line(y + 1, grid.row(x + 1)))
            end
            bottom_char = grid[x + 1, y]
            if bottom_char.match(/^(\d)+$/)
                bottom_row_matches.push(get_number_from_line(y, grid.row(x + 1)))
            end
            if y > 0
                bottom_left_char = grid[x + 1, y - 1]
                if bottom_left_char.match(/^(\d)+$/)
                    bottom_row_matches.push(get_number_from_line(y - 1, grid.row(x + 1)))
                end
                if bottom_row_matches.size() == 3
                    bottom_row_matches = bottom_row_matches.uniq
                end
                part_number_pair.push(*bottom_row_matches)
                left_char = grid[x, y - 1]
                if left_char.match(/^(\d)+$/)
                    part_number_pair.push(get_number_from_line(y - 1, grid.row(x)))
                end
            end
            sanitized = part_number_pair.compact.uniq
            if sanitized.size() == 2
                gear_ratios.push(sanitized.map(&:to_i).inject(:*))
            end
        end
    end
end

part_one = part_numbers.sum
part_two = gear_ratios.sum
puts part_two