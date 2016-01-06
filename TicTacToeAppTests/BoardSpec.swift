
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

        board = board.markSpace(0, mark: PlayerMark.X)

        expect(board.readSpace(0)).to(equal(PlayerMark.X))
      }

      it("does not have a winning line to start") {
        let board = Board()

        expect(board.hasWinningLine()).to(beFalse())
      }

      it("has a winning line when a line is all the same player's mark") {
        let board = Board(markedSpaces: [0 : PlayerMark.X, 1 : PlayerMark.X, 2 : PlayerMark.X])

        expect(board.hasWinningLine()).to(beTrue())
      }

      it("there are open spaces in a new game") {
        expect(Board().allSpacesMarked()).to(beFalse())
      }

      it("reports whether all spaces have been marked") {
        let markedSpaces = [
          0 : PlayerMark.X, 1 : PlayerMark.O, 2 : PlayerMark.X,
          3 : PlayerMark.X, 4 : PlayerMark.O, 5 : PlayerMark.X,
          6 : PlayerMark.O, 7 : PlayerMark.X, 8 : PlayerMark.O
        ]
        
        let board = Board(markedSpaces: markedSpaces)

        expect(board.allSpacesMarked()).to(beTrue())
      }
    }
  }
}
