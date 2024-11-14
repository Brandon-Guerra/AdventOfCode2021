require 'digest'

input = "bgvyzdsv"
number = 0

while true
    md5_hash = Digest::MD5.hexdigest(input + number.to_s)
    if md5_hash[0..5] == "000000"
        puts md5_hash
        puts number
        break
    end
    number += 1
end