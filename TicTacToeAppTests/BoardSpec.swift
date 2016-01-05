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

      it("there are open spaces in a new game") {
        expect(Board().allSpacesMarked()).to(beFalse())
      }

      it("reports whether all spaces have been marked") {
        let markedSpaces = [
          0 : Board.X, 1 : Board.O, 2 : Board.X,
          3 : Board.X, 4 : Board.O, 5 : Board.X,
          6 : Board.O, 7 : Board.X, 8 : Board.O
        ]
        
        let board = Board(markedSpaces: markedSpaces)

        expect(board.allSpacesMarked()).to(beTrue())
      }
    }
  }
}
