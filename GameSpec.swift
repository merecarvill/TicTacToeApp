import Quick
import Nimble
import TicTacToeApp

class GameSpec: QuickSpec {
  override func spec() {

    func makeSequenceOfMoves(game: Game, moves: [Int]) {
      for move in moves {
        game.makeMove(move)
      }
    }

    describe("Game") {

      it("is not over to start") {
        expect(Game().isOver()).to(beFalse())
      }

      it ("starts the game with player X moving first") {
        expect(Game().getCurrentPlayerMark()).to(equal(Board.X))
      }

      it("turns alternate between player X and player O") {
        let game = Game()
        let initialPlayerMark = game.getCurrentPlayerMark()

        game.makeMove(0)

        expect(initialPlayerMark).to(equal(Board.X))
        expect(game.getCurrentPlayerMark()).to(equal(Board.O))
      }

      it("is not over when no moves have been made") {
        expect(Game().isOver()).to(beFalse())
      }

      it("is over when first player (X) has 3 in a row") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 6])

        expect(game.isOver()).to(beTrue())
      }

      it("is over when all spaces have been marked") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 7, 6, 2, 5, 8])

        expect(game.isOver()).to(beTrue())
      }
    }
  }
}
