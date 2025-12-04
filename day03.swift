var banks: [[Int]] = []

while let line = readLine(strippingNewline: true) {
  let digits = Array(line).map { $0.wholeNumberValue! }
  banks.append(digits)
}

func largestJoltage(batteries: [Int], digits: Int) -> Int {
  var batteries = batteries[...]
  var result = 0
  for i in 1...digits {
    let digit = batteries.dropLast(digits - i).max()!
    result = result * 10 + digit
    batteries = batteries.drop(while: { $0 != digit }).dropFirst()
  }
  return result
}

let part1 = banks.map { largestJoltage(batteries: $0, digits: 2) }.reduce(0, +)
print(part1)  // 17311

let part2 = banks.map { largestJoltage(batteries: $0, digits: 12) }.reduce(0, +)
print(part2)  // 171419245422055
