input = File.read("input.txt")

nice_count = 0
naughty_count = 0

# part 1

# input.split("\n").each do |word|
#   if word.scan(/ab|cd|pq|xy/).count > 0
#     naughty_count += 1
#     next
#   end

#   if word.scan(/(.)\1/).count == 0
#     naughty_count += 1
#     next
#   end

#   if word.scan(/[aeiou]/).count < 3
#     naughty_count += 1
#     next
#   end

#   nice_count += 1
# end

# part 2

input.split("\n").each do |word|
    if word.scan(/(\w{2})\w*\1/).count == 0
        naughty_count += 1
        next
    end
    if word.scan(/(\w{1})\w{1}\1/).count == 0
        naughty_count += 1
        next
    end
    nice_count += 1
end

puts "Nice count: #{nice_count}"
puts "Naughty count: #{naughty_count}"