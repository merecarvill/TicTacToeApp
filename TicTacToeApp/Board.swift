public class Board {
  public static let BLANK = 0
  public static let X = 1
  public static let O = 2

  private let spaces: [Int: Int]
  private let size = 3

  public init() {
    spaces = [:]
  }

  public init(spaces: [Int: Int]) {
    self.spaces = spaces
  }

  public func markSpace(id: Int, mark: Int) -> Board {
    var newSpaces = spaces
    newSpaces[id] = mark

    return Board(spaces: newSpaces)
  }

  public func readSpace(id: Int) -> Int? {
    return spaces[id]
  }
}
