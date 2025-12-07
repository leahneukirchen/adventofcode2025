extension Collection where Self.Iterator.Element: RandomAccessCollection {
  func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
    self.first!.indices.map { index in
      self.map { $0[index] }
    }
  }
}

enum Op {
  case add
  case mul

  static func parse<T>(_ str: T) -> Op? where T: StringProtocol {
    switch str {
    case "+":
      .add
    case "*":
      .mul
    default:
      nil
    }
  }

  func compute(_ numbers: [Int]) -> Int {
    switch self {
    case .add:
      numbers.reduce(0, +)
    case .mul:
      numbers.reduce(1, *)
    }
  }
}

var numbers: [[Int]] = []
var ops: [Op] = []
var lines: [String] = []

while let line = readLine(strippingNewline: true) {
  if line.contains(where: { $0.isNumber }) {
    lines.append(line)
  } else {
    ops = line.split(separator: " ").map { Op.parse($0)! }
  }
}

let part1 = zip(
  ops,
  lines.map { $0.split(separator: " ").map { Int($0) ?? 0 } }.transposed()
).map { (op, row) in
  op.compute(row)
}.reduce(0, +)

print(part1)  // 6169101504608

let columns = lines.map { Array($0) }.transposed().split {
  $0.allSatisfy({ $0.isWhitespace })
}.map { columns in
  columns.map { Int(String($0.filter { $0.isNumber }))! }
}
let part2 = zip(ops, columns).map { (op, column) in
  op.compute(column)
}.reduce(0, +)

print(part2)  // 10442199710797
