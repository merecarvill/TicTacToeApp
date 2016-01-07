
public class Game {

  private var board: Board
  private var currentPlayer: PlayerMark

  public init() {
    board = Board()
    currentPlayer = PlayerMark.X
  }

  public func makeMove(boardSpace: Int) {
    board = board.markSpace(boardSpace, mark: currentPlayer)
    currentPlayer = otherPlayer()
  }

  public func getCurrentPlayer() -> PlayerMark {
    return currentPlayer
  }

  public func getInactivePlayer() -> PlayerMark {
    return otherPlayer()
  }

  public func playerWonLastTurn(mark: PlayerMark) -> Bool {
    return board.hasWinningLine() && currentPlayer != mark
  }

  public func isADraw() -> Bool {
    return board.allSpacesMarked() && !board.hasWinningLine()
  }

  public func getBoardMarks() -> [PlayerMark?] {
    return (0..<board.numberOfSpaces()).map{ board.readSpace($0) }
  }

  private func otherPlayer() -> PlayerMark {
    return currentPlayer == PlayerMark.X ? PlayerMark.O : PlayerMark.X
  }
}
