var ranges: [ClosedRange<Int>] = []
var ingredients: [Int] = []

while let line = readLine(strippingNewline: true), line != "" {
  let range = line.split(separator: "-", maxSplits: 2).map { Int($0) ?? 0 }
  ranges.append(range[0]...range[1])
}
while let line = readLine(strippingNewline: true) {
  ingredients.append(Int(line) ?? 0)
}

let part1 =
  ingredients.count { ingredient in
    ranges.contains(where: { $0.contains(ingredient) })
  }
print(part1)  // 601

var part2 = 0
var maxSeen = 0
for range in ranges.sorted(by: { $0.lowerBound < $1.lowerBound }) {
  if maxSeen < range.lowerBound {
    part2 += range.count
    maxSeen = range.upperBound
  } else if maxSeen < range.upperBound {
    part2 += range.upperBound - maxSeen
    maxSeen = range.upperBound
  }
}
print(part2)  // 367899984917516
