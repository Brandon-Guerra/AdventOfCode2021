input = File.read("input.txt")

locations = Hash.new(0)
santa_position = [0, 0]
robo_position = [0, 0]
locations[santa_position] += 1
counter = 0

def move(position, direction)
    case direction
    when "^"
        position[1] += 1
    when "v"
        position[1] -= 1
    when ">"
        position[0] += 1
    when "<"
        position[0] -= 1
    end
    return position
end

input.each_char do |char|
    if counter % 2 == 0
        move(santa_position, char)
        locations[santa_position.dup] += 1
    else
        move(robo_position, char)
        locations[robo_position.dup] += 1
    end
    counter += 1
end

puts locations.length
