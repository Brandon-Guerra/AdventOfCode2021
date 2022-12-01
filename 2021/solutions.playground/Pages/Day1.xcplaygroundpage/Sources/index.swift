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
    for index in 3...sonarDepths.count - 1 {
        if (Int(sonarDepths[index - 3]) < Int(sonarDepths[index])) {
            depthWindowIncreases += 1
        }
    }
    return depthWindowIncreases
}
