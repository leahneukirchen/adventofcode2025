var lines: [[Bool]] = []

while let line = readLine(strippingNewline: true) {
  lines.append(Array(line).map { $0 == "@" })
}

func countNeighbors(_ lines: [[Bool]], y: Int, x: Int) -> Int {
  var neighbors = 0
  for dy in -1...1 {
    for dx in -1...1 {
      if dx == 0 && dy == 0 {
        continue
      }
      if 0 <= y + dy && y + dy < lines.count && 0 <= x + dx && x + dx < lines[0].count {
        if lines[y + dy][x + dx] {
          neighbors += 1
        }
      }
    }
  }
  return neighbors
}

var part1 = 0
for y in 0..<lines.count {
  for x in 0..<lines[y].count {
    if lines[y][x] && countNeighbors(lines, y: y, x: x) < 4 {
      part1 += 1
    }
  }
}
print(part1)  // 1489

var part2 = 0
var new_lines = lines
repeat {
  lines = new_lines
  for y in 0..<lines.count {
    for x in 0..<lines[y].count {
      if lines[y][x] && countNeighbors(lines, y: y, x: x) < 4 {
        part2 += 1
        new_lines[y][x] = false
      }
    }
  }
} while new_lines != lines
print(part2)  // 8890
