public class Board {
  public static let X = 1
  public static let O = 2

  private let markedSpaces: [Int: Int]
  private let size = 3

  public init() {
    markedSpaces = [:]
  }

  public init(markedSpaces: [Int: Int]) {
    self.markedSpaces = markedSpaces
  }

  public func markSpace(id: Int, mark: Int) -> Board {
    var newSpaces = markedSpaces
    newSpaces[id] = mark

    return Board(markedSpaces: newSpaces)
  }

  public func readSpace(id: Int) -> Int? {
    return markedSpaces[id]
  }

  public func allSpacesMarked() -> Bool {
    return (0..<(size * size)).reduce(true, combine: { $0 && markedSpaces[$1] != nil })
  }

  public func hasWinningLine() -> Bool {
    return lines().reduce(false, combine: { $0 || lineHasAllSameMark($1) })
  }

  private func lineHasAllSameMark(line: [Int]) -> Bool {
    let lineMarks = line.map{ markedSpaces[$0] }

    return lineMarks.first! != nil &&
      lineMarks.reduce(true, combine: { $0 && $1 == lineMarks.first! })
  }

  private func lines() -> [[Int]] {
    return [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
  }
}