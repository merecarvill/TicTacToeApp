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

      it("does not have a winning line to start") {
        let board = Board()

        expect(board.hasWinningLine()).to(beFalse())
      }

      it("has a winning line when a line is all the same player's mark") {
        let board = Board(markedSpaces: [0 : Board.X, 1 : Board.X, 2 : Board.X])

        expect(board.hasWinningLine()).to(beTrue())
      }

      it("provides the ids of available spaces") {
        let boardSpaces = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

        expect(Board().availableSpaces()).to(equal(boardSpaces))
      }
    }
  }
}
