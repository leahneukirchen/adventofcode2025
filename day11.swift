var cables: [String: [String]] = [:]

while let line = readLine(strippingNewline: true) {
  let parts = line.split(separator: ": ")
  let outputs = parts[1].split(separator: " ").map { String($0) }
  cables[String(parts[0])] = outputs
}

var part1 = 0
func traverse(_ node: String) {
  if node == "out" {
    part1 += 1
  } else {
    for output in cables[node] ?? [] {
      traverse(output)
    }
  }
}
traverse("you")
print(part1)  // 603

// Tuples aren't hashable :(
struct Visited: Hashable {
  var node: String
  var dac: Bool
  var fft: Bool
}
var memo: [Visited: Int] = [:]
func traverse2(_ node: String, dac: Bool, fft: Bool) -> Int {
  if let result = memo[Visited(node: node, dac: dac, fft: fft)] {
    return result
  }
  let result =
    if node == "out" {
      dac && fft ? 1 : 0
    } else {
      (cables[node] ?? []).map { output in
        traverse2(
          output,
          dac: output == "dac" ? true : dac,
          fft: output == "fft" ? true : fft)
      }.reduce(0, +)
    }
  memo[Visited(node: node, dac: dac, fft: fft)] = result
  return result
}
print(traverse2("svr", dac: false, fft: false))  // 380961604031372
