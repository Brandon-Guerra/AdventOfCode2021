input = File.read("input.txt")

part_one = 0

lines = input.split("\n").map { |line|
    winning_numbers, my_numbers = line.split(" | ")
    winning_numbers = winning_numbers.split(" ")
    my_numbers = my_numbers.split(" ")
    winner_count = (winning_numbers & my_numbers).size()
    if winner_count > 0
        part_one += 2 ** (winner_count - 1)
    end
}

puts part_one

# lines = input.split("\n").map { |line|
#     components = line.split(" | ")
#     winning_numbers = components[0].split(" ")
#     my_numbers = components[1].split(" ")

#     winning_count = 0
#     my_numbers.map { |number|
#         if winning_numbers.include?(number)
#             winning_count += 1
#         end
#     }
#     if winning_count != 0
#         winners.push(winning_count)
#     end
# }
# winning_counts = winners.map{ |winner| 2 ** (winner - 1) }
# part_one = winning_counts.sum

# final = []
# copies = Array.new(lines.size()) { 1 }
# scoring_key = Hash.new
# copies.each_with_index { |count, index|
#     number_of_wins = winners[index]
#     if number_of_wins != nil
#         values_for_index = []
#         for y in (index + 2)...(index + number_of_wins + 2)
#             values_for_index.push(y)
#             copies[y] += count
#         end
#         scoring_key[index + 1] = values_for_index
#     end
# }

# scoring_key.each do |key, value|
#     final.concat(value)
#     times_value_appears = final.count(key)
#     if times_value_appears > 0
#         copies = value * times_value_appears
#         final.concat(copies)
#     end
# end

# puts final.size() + lines.size()