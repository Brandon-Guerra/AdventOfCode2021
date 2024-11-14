require 'matrix'

input = File.read("input.txt")
grid = Matrix.rows([])
input.split("\n").each do |row|
    grid = Matrix.rows(grid.to_a << row.split(""))
end



def check_neighbors (point, grid)
    current_elevation = grid[point[0], point[1]].ord
    is_start = current_elevation == 83
    row = point[0]

    top, bottom, left, right = nil
    if row > 0 and (grid[point[0] - 1, point[1]].ord <= current_elevation + 1 or is_start)
        top = grid[point[0] - 1, point[1]]
    end
    if point[0] < grid.row_count() and (grid[point[0] + 1, point[1]].ord <= current_elevation + 1 or is_start)
        bottom = grid[point[0] + 1, point[1]]
    end
    if point[1] > 0 and (grid[point[0], point[1] - 1].ord <= current_elevation + 1 or is_start)
        left = grid[point[0], point[1] - 1]
    end
    if point[1] < grid.column_count() and (grid[point[0], point[1] + 1].ord <= current_elevation + 1 or is_start)
        right = grid[point[0], point[1] + 1]
    end
    print(top, "|",  bottom, "|", left, "|", right)
end

start_index = grid.find_index('S')
check_neighbors(start_index, grid)