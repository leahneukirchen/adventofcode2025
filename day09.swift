var red: [(Int, Int)] = []

while let line = readLine(strippingNewline: true) {
  let vals = line.split(separator: ",", maxSplits: 2).map { Int($0) ?? 0 }
  red.append((vals[0], vals[1]))
}
red.append(red[0])              // close the loop

var part1 = 0
var part2 = 0
for i in 0..<red.count - 1 {
  loop: for j in (i + 1)..<red.count - 1 {
    let minX = min(red[i].0, red[j].0)
    let minY = min(red[i].1, red[j].1)
    let maxX = max(red[i].0, red[j].0)
    let maxY = max(red[i].1, red[j].1)

    let size = (maxX - minX + 1) * (maxY - minY + 1)
    part1 = max(part1, size)

    if size > part2 {
      for k in 0..<red.count - 1 {
        if (minX < max(red[k].0, red[k + 1].0) && maxX > min(red[k].0, red[k + 1].0)
              && minY < max(red[k].1, red[k + 1].1) && maxY > min(red[k].1, red[k + 1].1))
        {
          continue loop
        }
      }
      part2 = size
    }
  }
}

print(part1)  // 4741451444
print(part2)  // 1562459680
