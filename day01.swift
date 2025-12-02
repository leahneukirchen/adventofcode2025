var steps: [Int] = []

while let line = readLine(strippingNewline: true) {
  let dir = line.prefix(1)
  let num = Int(line.dropFirst(1)) ?? 0

  steps.append(dir == "L" ? -num : num)
}

let part1 =
  steps.reduce(into: [50]) { list, step in
    list.append((list.last! + step) % 100)
  }.count(where: { $0 == 0 })

print(part1)  // 1152

let part2 =
  steps.flatMap {
    Array(repeating: $0.signum(), count: abs($0))
  }.reduce(into: [50]) { list, step in
    list.append((list.last! + step) % 100)
  }.count(where: { $0 == 0 })

print(part2)  // 6671
