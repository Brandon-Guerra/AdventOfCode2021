var input = "1,3,1,5,5,1,1,1,5,1,1,1,3,1,1,4,3,1,1,2,2,4,2,1,3,3,2,4,4,4,1,3,1,1,4,3,1,5,5,1,1,3,4,2,1,5,3,4,5,5,2,5,5,1,5,5,2,1,5,1,1,2,1,1,1,4,4,1,3,3,1,5,4,4,3,4,3,3,1,1,3,4,1,5,5,2,5,2,2,4,1,2,5,2,1,2,5,4,1,1,1,1,1,4,1,1,3,1,5,2,5,1,3,1,5,3,3,2,2,1,5,1,1,1,2,1,1,2,1,1,2,1,5,3,5,2,5,2,2,2,1,1,1,5,5,2,2,1,1,3,4,1,1,3,1,3,5,1,4,1,4,1,3,1,4,1,1,1,1,2,1,4,5,4,5,5,2,1,3,1,4,2,5,1,1,3,5,2,1,2,2,5,1,2,2,4,5,2,1,1,1,1,2,2,3,1,5,5,5,3,2,4,2,4,1,5,3,1,4,4,2,4,2,2,4,4,4,4,1,3,4,3,2,1,3,5,3,1,5,5,4,1,5,1,2,4,2,5,4,1,3,3,1,4,1,3,3,3,1,3,1,1,1,1,4,1,2,3,1,3,3,5,2,3,1,1,1,5,5,4,1,2,3,1,3,1,1,4,1,3,2,2,1,1,1,3,4,3,1,3"

var lanternFish = input.split(separator: ",")
    .map { Int($0)! }
    .reduce([:], { acc, cur in
        var values = acc
        values[cur] = (values[cur] as? Int ?? 0) + 1
        return values
})

for _ in 1...256 {
    let zeroCount = lanternFish[0] as? Int ?? 0
    for fish in 0...7 {
        // count each fish down 1
        lanternFish[fish] = lanternFish[fish + 1] ?? 0
    }
    // respawned fish
    let respawnedFishCount = lanternFish[6] as? Int ?? 0
    lanternFish[6] = respawnedFishCount + zeroCount
    // new fish
    lanternFish[8] = zeroCount
}
var finalCounts: [Int] = []
lanternFish.mapValues { fish in
    finalCounts.append(fish as! Int)
}
print(finalCounts.reduce(0, +))
