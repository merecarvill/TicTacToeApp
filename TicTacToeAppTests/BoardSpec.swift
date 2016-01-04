import Quick
import Nimble
import TicTacToeApp

class BoardSpec: QuickSpec {
  override func spec() {

    describe("Board") {

      it("is unmarked to start") {
        let board = Board()

        expect(board.readSpace([0,0])).to(equal(Board.BLANK))
      }

      it("records a player's mark") {
        let board = Board()

        board.markSpace([0, 0], mark: Board.X)

        expect(board.readSpace([0, 0])).to(equal(Board.X))
      }
    }
  }
}
