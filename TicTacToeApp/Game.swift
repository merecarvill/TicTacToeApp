public class Game {

  private var board: Board
  private var currentPlayer: Int

  public init() {
    board = Board()
    currentPlayer = Board.X
  }

  public func makeMove(boardSpace: Int) {
    board = board.markSpace(boardSpace, mark: currentPlayer)
    currentPlayer = togglePlayer()
  }

  public func getCurrentPlayer() -> Int {
    return currentPlayer
  }

  public func playerWonLastTurn(mark: Int) -> Bool {
    return board.hasWinningLine() && currentPlayer != mark
  }

  public func isADraw() -> Bool {
    return board.allSpacesMarked() && !board.hasWinningLine()
  }

  private func togglePlayer() -> Int {
    return currentPlayer == Board.X ? Board.O : Board.X
  }
}