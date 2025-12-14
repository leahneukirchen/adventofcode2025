var steps: [Int] = []

var part1 = 0
while let line = readLine(strippingNewline: true) {
  if !line.contains("x") {
    continue
  }
  let nums: [Int] = line.matches(of: #/\d+/#).map { Int($0.0)! }
  let size = nums[0] * nums[1]
  let total = nums[2...].reduce(0, +)
  if total <= size / 9 {
    part1 += 1
  }
}

print(part1)  // 577
