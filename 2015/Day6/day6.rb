def toggle_grid(grid, instruction, x1, y1, x2, y2)
    case instruction
    when "turnon"
        (x1..x2).each do |x|
            (y1..y2).each do |y|
                grid[x][y] = grid[x][y] + 1
            end
        end
    when "turnoff"
        (x1..x2).each do |x|
            (y1..y2).each do |y|
                grid[x][y] = (grid[x][y] - 1) < 0 ? 0 : grid[x][y] - 1
            end
        end
    when "toggle"
        (x1..x2).each do |x|
            (y1..y2).each do |y|
                grid[x][y] = grid[x][y] + 2
            end
        end
    end
end

require 'matrix'

input = File.read("input.txt")
light_grid = Array.new(1000) { Array.new(1000, 0) }

input.split("\n").each do |line|
  instruction, start_coords, _, end_coords = line.split(" ")
  x1, y1 = start_coords.split(",").map(&:to_i)
  x2, y2 = end_coords.split(",").map(&:to_i)
  toggle_grid(light_grid, instruction, x1, y1, x2, y2)
end

puts light_grid.flatten.sum