import Foundation

func decodeDigitDisplay(signalPatterns: [String], outputValue: [String]) -> String {
    // for digits
    var possibleDigitValues: [Int: [String]] = [:]
    for signal in signalPatterns {
        switch signal.count {
        // for digit 1
        case 2:
            if possibleDigitValues[1] != nil {
                possibleDigitValues[1]! += [signal]
            } else {
                possibleDigitValues[1] = [signal]
            }
        // for digit 7
        case 3:
            if possibleDigitValues[7] != nil {
                possibleDigitValues[7]! += [signal]
            } else {
                possibleDigitValues[7] = [signal]
            }
        // for digit 4
        case 4:
            if possibleDigitValues[4] != nil {
                possibleDigitValues[4]! += [signal]
            } else {
                possibleDigitValues[4] = [signal]
            }
        // for digit 8
        case 7:
            if possibleDigitValues[8] != nil {
                possibleDigitValues[8]! += [signal]
            } else {
                possibleDigitValues[8] = [signal]
            }
        // for digits 2, 5, and 3
        case 5:
            if possibleDigitValues[2] != nil {
                possibleDigitValues[2]! += [signal]
            } else {
                possibleDigitValues[2] = [signal]
            }
            if possibleDigitValues[3] != nil {
                possibleDigitValues[3]! += [signal]
            } else {
                possibleDigitValues[3] = [signal]
            }
            if possibleDigitValues[5] != nil {
                possibleDigitValues[5]! += [signal]
            } else {
                possibleDigitValues[5] = [signal]
            }
        // for digit 0
        case 6:
            if possibleDigitValues[0] != nil {
                possibleDigitValues[0]! += [signal]
            } else {
                possibleDigitValues[0] = [signal]
            }
            if possibleDigitValues[6] != nil {
                possibleDigitValues[6]! += [signal]
            } else {
                possibleDigitValues[6] = [signal]
            }
            if possibleDigitValues[9] != nil {
                possibleDigitValues[9]! += [signal]
            } else {
                possibleDigitValues[9] = [signal]
            }
        default:
            break
        }
    }
    // filter down 3 options
    let set7 = Array(possibleDigitValues[7]!.first!)
    let newSet3 = possibleDigitValues[3]?.filter { value in
        let set3 = Set(Array(value))
        let difference = set3.subtracting(set7)
        return difference.count == 2
    }
    possibleDigitValues[3] = newSet3!
    
    // filter down 9 options
    let set4 = Array(possibleDigitValues[4]!.first!)
    let newSet9 = possibleDigitValues[9]?.filter { value in
        let set9 = Set(Array(value))
        let difference = set9.subtracting(set4)
        return difference.count == 2
    }
    possibleDigitValues[9] = newSet9!
    
    // filter down 6 options
    let set1 = Array(possibleDigitValues[1]!.first!)
    let newSet6 = possibleDigitValues[6]?.filter { value in
        let set6 = Set(Array(value))
        let difference = set6.subtracting(set1)
        return difference.count == 5
    }
    possibleDigitValues[6] = newSet6!
    
    // filter down 0 options
    let set5 = Array(possibleDigitValues[5]!.first!)
    let newSet0 = possibleDigitValues[0]?.filter { value in
        let set0 = Set(Array(value))
        let difference = set0.subtracting(set5)
        return difference.count == 2
    }
    possibleDigitValues[0] = newSet0!
    
    // filter down 2 options
    let set9 = Array(possibleDigitValues[9]!.first!)
    let newSet2 = possibleDigitValues[2]?.filter { value in
        let set2 = Set(Array(value))
        let difference = set2.subtracting(set9)
        return difference.count == 1
    }
    possibleDigitValues[2] = newSet2!
    
    // filter down 5 options
    let set6 = Array(possibleDigitValues[6]!.first!)
    let newSet5 = possibleDigitValues[5]?.filter { value in
        let set5 = Set(Array(value))
        let difference = set5.subtracting(set6)
        return difference.count == 0
    }
    possibleDigitValues[5] = newSet5!
    
    var finalOutput = ""
    for digit in outputValue {
        for (key, value) in possibleDigitValues {
            let valueSet = Set(value.first!.map{ String($0) })
            let digitSet = Set(digit.map { String($0) })
            if digitSet.isSubset(of: valueSet) && valueSet.isSubset(of: digitSet) {
                finalOutput += String(key)
            }
        }
    }
    return finalOutput
}

public func part1(outputValues: [String]) -> Int {
    let finalValues = outputValues.filter { output in
        switch output.count {
        case 2, 4, 3, 7:
            return true
        default:
            return false
        }
    }
    return finalValues.count
}

public func part2(lines: [String]) -> Int {
    let solution = lines.reduce(0, { numberTotal, line in
        let signalPatterns = line.components(separatedBy: " | ").first!.components(separatedBy: " ")
        let outputValue = line.components(separatedBy: " | ").last!.components(separatedBy: " ")
        let number = Int(decodeDigitDisplay(signalPatterns: signalPatterns, outputValue: outputValue))!
        print(number)
        return numberTotal + number
    })
    
    // for segments
//    var segmentMappings: [String: String] = [:]
//    let aMapping = String(Set(set7).subtracting(Set(set1)).first!)
//    segmentMappings["a"] = aMapping
//
//    let set0 = Array(possibleDigitValues[0]!.first!)
//    let set8 = Array(possibleDigitValues[8]!.first!)
//    let dMapping = String(Set(set8).subtracting(Set(set0)).first!)
//    segmentMappings["d"] = dMapping
//
//    let eMapping = String(Set(set6).subtracting(Set(set5)).first!)
//    segmentMappings["e"] = eMapping
//
//    let set2 = Array(possibleDigitValues[2]!.first!)
//    let set3 = Array(possibleDigitValues[3]!.first!)
//    let fMapping = String(Set(set3).subtracting(Set(set2)).first!)
//    segmentMappings["f"] = fMapping
//
//    let cMapping = String(Set(set2).subtracting(Set(set6)).first!)
//    segmentMappings["c"] = cMapping
//
//    let bMapping = String(Set(set0).subtracting(Set(set2)).subtracting(set1).first!)
//    segmentMappings["b"] = bMapping
//
//    let gMapping = String(Set(set9).subtracting(Set(set7)).subtracting(set4).first!)
//    segmentMappings["g"] = gMapping
    
    return solution
}
