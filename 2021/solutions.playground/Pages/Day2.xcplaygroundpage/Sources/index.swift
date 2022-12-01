enum Direction: String {
    case up
    case down
    case forward
}

// part 1
public func part1(_ commands: [String]) -> Int {
    var horizontalPosition = 0
    var depth = 0
    
    for command in commands {
        let components = command.components(separatedBy: " ")
        let direction = Direction(rawValue: components[0])
        let magnitude = Int(components[1])!
        
        switch direction {
        case .up:
            depth -= magnitude
        case .down:
            depth += magnitude
        case .forward:
            horizontalPosition += magnitude
        case .none:
            break
        }
    }
    
    return horizontalPosition * depth
}

// part2
public func part2(_ commands: [String]) -> Int {
    var horizontalPosition = 0
    var depth = 0
    var aim = 0
    
    for command in commands {
        let components = command.components(separatedBy: " ")
        let direction = Direction(rawValue: components[0])
        let magnitude = Int(components[1])!
        
        switch direction {
        case .up:
            aim -= magnitude
        case .down:
            aim += magnitude
        case .forward:
            horizontalPosition += magnitude
            depth += magnitude * aim
        case .none:
            break
        }
    }
    
    return horizontalPosition * depth
}
