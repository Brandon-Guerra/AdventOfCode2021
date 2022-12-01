import Foundation

public func solve<T>(partNumber: Int, input: T, function: (T) -> Any) {
    let start = CFAbsoluteTimeGetCurrent()
    let solution = function(input)
    let elapsedTime = CFAbsoluteTimeGetCurrent() - start
    print("The solution to part \(partNumber) is \(solution)")
    print("Execution time: \(elapsedTime)s")
}
