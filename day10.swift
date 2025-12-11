public struct Machine {
  public var target: Int16
  public var buttons: [Int16]
  public var joltages: [Int]
}

var machines: [Machine] = []

let rx = #/^\[([#.]*)\] (.*?) \{(.*)\}/#

while let line = readLine(strippingNewline: true) {
  if let result = try? rx.wholeMatch(in: line) {
    var target: Int16 = 0
    for char in result.1.reversed() {
      target *= 2
      if char == "#" {
        target += 1
      }
    }

    var buttons: [Int16] = []
    for buttonGroup in result.2.split(separator: " ") {
      var mask: Int16 = 0
      for button in buttonGroup.dropFirst().dropLast().split(separator: ",") {
        mask |= 1 << Int16(button)!
      }
      buttons.append(mask)
    }

    let joltages = result.3.split(separator: ",").map { Int($0)! }

    machines.append(Machine(target: target, buttons: buttons, joltages: joltages))
  }
}

// exhaustive search is a lot faster than DFS with a stack
let part1 = machines.map { m in
  var minSteps = 99999
  for i in 0..<1 << 16 {
    var state: Int16 = 0
    var steps = 0
    for j in 0..<m.buttons.count {
      if i & (1 << j) != 0 {
        state ^= m.buttons[j]
        steps += 1
      }
    }
    if state == m.target {
      minSteps = min(minSteps, steps)
    }
  }
  return minSteps
}.reduce(0, +)
print("; part1:", part1)  // 488

// generate a z3 program to solve this
print("(declare-const part2 Int)")
for (i, m) in machines.enumerated() {
  print("(declare-const m\(i) Int)")
  for (j, _) in m.buttons.enumerated() {
    print("(declare-const m\(i)b\(j) Int)")
    print("(assert (>= m\(i)b\(j) 0))")
  }
}

for (i, m) in machines.enumerated() {
  for (j, v) in m.joltages.enumerated() {
    print("(assert (= (+", terminator: "")
    for (k, b) in m.buttons.enumerated() {
      if b & (1 << j) != 0 {
        print(" m\(i)b\(k)", terminator: "")
      }
    }
    print(") \(v)))")
  }

  print("(assert (= m\(i) (+", terminator: "")
  for (j, _) in m.buttons.enumerated() {
    print(" m\(i)b\(j)", terminator: "")
  }
  print(")))")
  print("(minimize m\(i))")
}

print("(assert (= (+", terminator: "")
for (i, _) in machines.enumerated() {
  print(" m\(i)", terminator: "")
}
print(") part2))")

print("(check-sat)")
print("(get-value (part2))")
