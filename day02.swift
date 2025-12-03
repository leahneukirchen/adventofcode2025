/*** String/Regex based approaches, but they are quite slow:

func isSilly(_ i: Int) -> Bool {
  let s = String(i)
  if s.count % 2 == 1 {
    return false
  } else {
    return s.hasSuffix(s.prefix(s.count / 2))
  }
}

let rx = #/^(.+)\1+$/#
func isSilly2(_ i: Int) -> Bool {
  return String(i).contains(rx)
}

***/

func isRepeat(array: [UInt8], length: Int) -> Bool {
  guard length > 0 && array.count % length == 0 else {
    return false
  }
  for j in 0..<length {
    for k in 1..<(array.count / length) {
      if array[j] != array[k * length + j] {
        return false
      }
    }
  }
  return true
}

func isSilly1(_ i: Int) -> Bool {
  let digits = Array(String(i).utf8)
  return digits.count % 2 == 0 && isRepeat(array: digits, length: digits.count / 2)
}

func isSilly2(_ i: Int) -> Bool {
  let digits = Array(String(i).utf8)
  return (0...digits.count / 2).contains {
    isRepeat(array: digits, length: $0)
  }
}

let input = readLine(strippingNewline: true)!

let ranges = input.split(separator: ",").map {
  let range = $0.split(separator: "-", maxSplits: 2).map { Int($0) ?? 0 }
  return range[0]...range[1]
}

let part1 = ranges.flatMap { $0.filter(isSilly1) }.reduce(0, +)
print(part1)  // 30608905813

let part2 = ranges.flatMap { $0.filter(isSilly2) }.reduce(0, +)
print(part2)  // 31898925685
