import Quick
import Nimble
import TicTacToeApp

class BoardSpec: QuickSpec {
  override func spec() {

    describe("Board") {

      it("is unmarked to start") {
        let board = Board()

        expect(board.readSpace(0)).to(beNil())
      }

      it("records a player's mark") {
        var board = Board()

        board = board.markSpace(0, mark: Board.X)

        expect(board.readSpace(0)).to(equal(Board.X))
      }
    }
  }
}
