var lines: [[Character]] = []

while let line = readLine(strippingNewline: true) {
  lines.append(Array(line))
}

var part1 = 0
var beamCount: [Int] = lines[0].map { $0 == "S" ? 1 : 0 }
for line in lines[1...] {
  var nextBeamCount = Array(repeating: 0, count: beamCount.count)
  for (i, count) in beamCount.enumerated() {
    if count > 0 {
      if line[i] == "^" {
        part1 += 1
        nextBeamCount[i - 1] += count
        nextBeamCount[i + 1] += count
      } else {
        nextBeamCount[i] += count
      }
    }
  }
  beamCount = nextBeamCount
}
let part2 = beamCount.reduce(0, +)
print(part1)  // 1537
print(part2)  // 18818811755665
