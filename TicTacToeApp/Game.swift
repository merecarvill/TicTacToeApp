public class Game {
  public enum Player {
    case First
    case Second
  }

  private var board: Board
  private var currentPlayer: Player

  public init() {
    board = Board()
    currentPlayer = Player.First
  }

  public func makeMove(boardSpace: Int) {
    currentPlayer = toggleCurrentPlayer()
  }

  public func getCurrentPlayer() -> Player {
    return currentPlayer
  }

  public func isOver() -> Bool {
    return false
  }

  private func toggleCurrentPlayer() -> Player {
    return currentPlayer == Player.First ? Player.Second : Player.First
  }
}