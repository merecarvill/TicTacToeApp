public class Game {

  private var board: Board
  private var currentPlayerMark: Int

  public init() {
    board = Board()
    currentPlayerMark = Board.X
  }

  public func makeMove(boardSpace: Int) {
    board = board.markSpace(boardSpace, mark: currentPlayerMark)
    currentPlayerMark = togglePlayerMark()
  }

  public func getCurrentPlayerMark() -> Int {
    return currentPlayerMark
  }

  public func playerWonLastTurn(mark: Int) -> Bool {
    return board.hasWinningLine() && currentPlayerMark != mark
  }

  public func isADraw() -> Bool {
    return board.allSpacesMarked() && !board.hasWinningLine()
  }

  private func togglePlayerMark() -> Int {
    return currentPlayerMark == Board.X ? Board.O : Board.X
  }
}