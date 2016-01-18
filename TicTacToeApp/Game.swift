
public class Game {

  private var board: Board
  private var currentPlayer: PlayerMark

  public init() {
    board = Board()
    currentPlayer = .X
  }

  public func makeMove(space: Int) {
    board = board.markSpace(space, mark: currentPlayer)
    currentPlayer = otherPlayer()
  }

  public func getCurrentPlayer() -> PlayerMark {
    return currentPlayer
  }

  public func getInactivePlayer() -> PlayerMark {
    return otherPlayer()
  }

  public func playerWon(mark: PlayerMark) -> Bool {
    return board.hasWinningLine() && currentPlayer != mark
  }

  public func isADraw() -> Bool {
    return board.isFull() && !board.hasWinningLine()
  }

  public func isOver() -> Bool {
    return isADraw() || playerWon(currentPlayer) || playerWon(otherPlayer())
  }

  public func getBoardMarks() -> [PlayerMark?] {
    return (0..<board.numberOfSpaces()).map{ board.readSpace($0) }
  }

  private func otherPlayer() -> PlayerMark {
    return currentPlayer == .X ? .O : .X
  }
}
