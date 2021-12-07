import Foundation

public func part1(crabPositions: [Int]) -> Int {
    let lowerBound = crabPositions.min()
    let upperBound = crabPositions.max()
    
    var lowestFuelCost = Int.max
    for position in lowerBound!...upperBound! {
        let fuelCost = crabPositions.reduce(0, { acc, cur in
            return acc + abs(cur - position)
        })
        if fuelCost < lowestFuelCost {
            lowestFuelCost = fuelCost
        }
    }
    return lowestFuelCost
}

public func part2(crabPositions: [Int]) -> Int {
    let lowerBound = crabPositions.min()
    let upperBound = crabPositions.max()
    var lowestFuelCost = Int.max
    
    for position in lowerBound!...upperBound! {
        let fuelCost = crabPositions.reduce(0, { acc, cur in
            let initialFuelCost = abs(cur - position)
            let nextPosition = initialFuelCost - 1
            let cumulativeFuelCost = (nextPosition * (nextPosition + 1)) / 2
            return acc + initialFuelCost + cumulativeFuelCost
        })
        if fuelCost < lowestFuelCost {
            lowestFuelCost = fuelCost
        }
    }
    return lowestFuelCost
}
