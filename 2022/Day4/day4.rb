require 'set'
input = File.read("input.txt")

assignments = input.split("\n").map { |assignment| assignment.split(",") }
set_pairs = assignments.map do |pair|
    pair.map do |assignment|
        ids = assignment.split("-")
        min = ids[0].to_i
        max = ids[1].to_i
        assignment = Set.new(min..max)
    end
end

part1 = set_pairs.select { |pair| pair[0].subset?(pair[1]) or pair[1].subset?(pair[0])}.count
part2 = set_pairs.select { |pair| pair[0].intersection(pair[1]).count != 0 }.count