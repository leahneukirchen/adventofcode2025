import Foundation

// don't have Spatial.Vector3D on Linux
public struct Vector3: Hashable {
  public var x: Double
  public var y: Double
  public var z: Double

  func distance(_ other: Vector3) -> Double {
    (pow(self.x - other.x, 2.0) + pow(self.y - other.y, 2.0) + pow(self.z - other.z, 2.0))
      .squareRoot()
  }
}

var boxes: [Vector3] = []

while let line = readLine(strippingNewline: true) {
  let nums = line.split(separator: ",").map { Double($0)! }
  boxes.append(Vector3(x: nums[0], y: nums[1], z: nums[2]))
}

var connections: [(Int, Int)] = []
for i in 0..<boxes.count {
  for j in (i + 1)..<boxes.count {
    connections.append((i, j))
  }
}

connections.sort { a, b in
  boxes[a.0].distance(boxes[a.1]) < boxes[b.0].distance(boxes[b.1])
}

var part2 = 0
var parents = Array(0..<boxes.count)  // union find
for (n, (i, j)) in connections.enumerated() {
  var ipos = i
  var jpos = j
  while parents[ipos] != ipos {
    ipos = parents[ipos]
  }
  while parents[jpos] != jpos {
    jpos = parents[jpos]
  }
  parents[i] = ipos
  parents[j] = jpos

  if n == 1000 {
    var sets = Array(repeating: 0, count: parents.count)
    for i in 0..<parents.count {
      var ipos = i
      while parents[ipos] != ipos {
        ipos = parents[ipos]
      }
      sets[ipos] += 1
    }

    let part1 = sets.sorted().suffix(3).reduce(1, *)
    print(part1)  // 50760
  }

  if ipos != jpos {
    part2 = Int(boxes[i].x * boxes[j].x)
    parents[ipos] = jpos
  }

  if parents.allSatisfy({ $0 == parents[0] }) {
    break
  }
}

print(part2)  // 3206508875
