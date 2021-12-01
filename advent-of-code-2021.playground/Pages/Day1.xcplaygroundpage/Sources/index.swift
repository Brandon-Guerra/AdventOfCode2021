// part 1
public func part1(_ sonarDepths: [Int]) -> Int {
    var depthMeasurementIncreases = 0
    for index in 1...sonarDepths.count - 1 {
        if (sonarDepths[index - 1] < sonarDepths[index]) {
            depthMeasurementIncreases += 1
        }
    }
    return depthMeasurementIncreases
}

// part 2
public func part2(_ sonarDepths: [Int]) -> Int {
    var depthWindowIncreases = 0
    for index in 2...sonarDepths.count - 1 {
        if (index + 1 <= sonarDepths.count - 1) {
            let firstWindowSum = Int(sonarDepths[index - 2]) + Int(sonarDepths[index - 1]) + Int(sonarDepths[index])
            let secondWindowSum = Int(sonarDepths[index + 1]) + Int(sonarDepths[index]) + Int(sonarDepths[index - 1])
            if (firstWindowSum < secondWindowSum) {
                depthWindowIncreases += 1
            }
        }
    }
    return depthWindowIncreases
}
