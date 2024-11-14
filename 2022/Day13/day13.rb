input = File.read("input.txt")

def convert_string_to_list (input)
    # components = input.split(/[\[\]]/).select { |component| component != "" }
    first, *rest = input.split("")
    print(first, "\n")
    print(rest, "\n")
    # if first == "["
    #     convert_string_to_list(rest)
    # elsif first == "]"
end

print(convert_string_to_list("[1,[2,[3,[4,[5,6,7]]]],8,9]".tr(",", "")), "\n")
convert_string_to_list("[]")

# first = []
# second = []

# counter = 0
# input.split("\n\n").each do |pair|
#     pair.split("\n").each do |list|
#         counter +=1
#         if counter % 2 == 0
#             second.append(list)
#         else
#             first.append(list)
#         end
#     end
# end