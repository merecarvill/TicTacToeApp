
public class Board {
  
  private let markedSpaces: [Int: PlayerMark]
  private let size = 3

  public init() {
    markedSpaces = [:]
  }

  public init(markedSpaces: [Int : PlayerMark]) {
    self.markedSpaces = markedSpaces
  }

  public func markSpace(space: Int, mark: PlayerMark) -> Board {
    var newSpaces = markedSpaces
    newSpaces[space] = mark

    return Board(markedSpaces: newSpaces)
  }

  public func readSpace(space: Int) -> PlayerMark {
    return markedSpaces[space] ?? PlayerMark.NONE
  }

  public func isFull() -> Bool {
    return (0..<numberOfSpaces()).reduce(true, combine: { $0 && markedSpaces[$1] != nil })
  }

  public func hasWinningLine() -> Bool {
    return lines().reduce(false, combine: { $0 || lineHasAllSameMark($1) })
  }

  public func numberOfSpaces() -> Int {
    return size * size
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
