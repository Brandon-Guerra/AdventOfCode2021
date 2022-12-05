stacks_input = File.read("stacks.txt")
stacks_part1 = [[],[],[],[],[],[],[],[],[]]
stacks_part2 = [[],[],[],[],[],[],[],[],[]]
stacks_input.split("\n").each do |row|
    row.split("").each_with_index do |char, index|
        if char != " " and char != "[" and char != "]"
            column = (index + 3) / 4 - 1
            stacks_part1[column].prepend(char)
            stacks_part2[column].prepend(char)
        end
    end
end

moves_input = File.read("moves.txt")
moves_input.split("\n").each do |row|
    quantity = row.match(/(?<=move )\d*/)[0].to_i
    from = row.match(/(?<=from )\d*/)[0].to_i
    to = row.match(/(?<=to )\d*/)[0].to_i
    popped1 = stacks_part1[from - 1].pop(quantity).reverse()
    popped2 = stacks_part2[from - 1].pop(quantity)
    stacks_part1[to - 1].push(*popped1)
    stacks_part2[to - 1].push(*popped2)
end
part1 = stacks_part1.map { |stack| stack.pop() }.join()
part2 = stacks_part2.map { |stack| stack.pop() }.join()