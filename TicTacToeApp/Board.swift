public class Board {
  public static let BLANK = 0
  public static let X = 1
  public static let O = 2

  private var spaces: [Int?]
  private let size = 3

  public init() {
    spaces = [Int?](count: 9, repeatedValue: Board.BLANK)
  }

  public init(spaces: [Int?]) {
    self.spaces = spaces
  }

  public func markSpace(coordinates: [Int], mark: Int) -> Board {
    spaces[coordinatesToIndex(coordinates)] = mark

    return Board(spaces: spaces)
  }

  public func readSpace(coordinates: [Int]) -> Int? {
    return spaces[coordinatesToIndex(coordinates)]
  }

  private func coordinatesToIndex(coordinates: [Int]) -> Int {
    let row = coordinates[0]
    let col = coordinates[1]

    return row * size + col
  }
}
