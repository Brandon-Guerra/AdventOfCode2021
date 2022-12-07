import Foundation

class Node<Value> {
    var value: Value
    var name: String
    private(set) var children: [Node]
    private(set) var parent: Node?
    
    var total: Int {
        value as! Int + children.reduce(0) { $0 + $1.total }
    }

    func add(child: Node) {
        children.append(child)
    }
    
    func add(parent: Node) {
        self.parent = parent
    }

    init(_ value: Value, name: String = "") {
        self.value = value
        self.name = name
        children = []
    }

    init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
        self.name = ""
    }
}

extension Node where Value: Equatable {
    func find(_ name: String) -> Node? {
        if self.name == name {
            return self
        }

        for child in children {
            if let match = child.find(name) {
                return match
            }
        }

        return nil
    }
}

func createTreeFromInput(input: String) -> Node<Int> {
    let root = Node(0)
    var currentNode = root

    let terminalOutput = input.components(separatedBy: "\n")
    for line in terminalOutput {
        let components = line.components(separatedBy: " ")
        switch components[0] {
        case "$":
            switch components[1] {
                case "cd":
                    let destination = components[2]
                    switch destination {
                        case "/":
                        currentNode = root
                        case "..":
                        if let parent = currentNode.parent {
                            currentNode = parent
                        }
                        default:
                        if let directoryToChangeTo = currentNode.find("\(currentNode.parent?.name ?? "")\(destination)") {
                            currentNode = directoryToChangeTo
                        }
                    }
                case "ls":
                    break
                default:
                    break
            }
        case "dir":
            let dirName = components[1]
            let newNode = Node(0, name: "\(currentNode.parent?.name ?? "")\(dirName)")
            newNode.add(parent: currentNode)
            currentNode.add(child: newNode)
        default:
            let newNode = Node(Int(components[0])!, name: components[1])
            newNode.add(parent: currentNode)
            currentNode.add(child: newNode)
        }
    }
    return root
}

func traverseForPart1(node: Node<Int>) {
    if node.value == 0 && node.total <= 100000 { directoriesValuesForPart1.append(node.total) }
    for child in node.children {
        traverseForPart1(node: child)
    }
}

let directory = createTreeFromInput(input: input)
var directoriesValuesForPart1: [Int] = []
traverseForPart1(node: directory)

let part1 = directoriesValuesForPart1.reduce(0, +)
print(part1)

let fileSystemDiskSpace = 70000000
let unusedSpaceThreshold = 30000000
let usedSpace = directory.total
let unusedSpace = fileSystemDiskSpace - usedSpace
var directoriesValuesForPart2: [Int] = []

func traverseForPart2(node: Node<Int>) {
    if node.value == 0 && unusedSpace + node.total > unusedSpaceThreshold { directoriesValuesForPart2.append(node.total) }
    for child in node.children {
        traverseForPart2(node: child)
    }
}
traverseForPart2(node: directory)

let part2 = directoriesValuesForPart2.min()
print(part2 ?? "")