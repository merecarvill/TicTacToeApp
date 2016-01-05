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

      it ("starts the game with player X moving first") {
        expect(Game().getCurrentPlayer()).to(equal(Board.X))
      }

      it("turns alternate between player X and player O") {
        let game = Game()
        let initialPlayer = game.getCurrentPlayer()

        game.makeMove(0)

        expect(initialPlayer).to(equal(Board.X))
        expect(game.getCurrentPlayer()).to(equal(Board.O))
      }

      it("has no winning players when just starting a game") {
        expect(Game().playerWonLastTurn(Board.X)).to(beFalse())
        expect(Game().playerWonLastTurn(Board.O)).to(beFalse())
      }

      it("reports if player X won") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 6])

        expect(game.playerWonLastTurn(Board.X)).to(beTrue())
      }

      it("reports if player O won") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 2, 4, 3, 7])

        expect(game.playerWonLastTurn(Board.O)).to(beTrue())
      }

      it("reports if game is a draw") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 7, 6, 2, 5, 8])

        expect(game.isADraw()).to(beTrue())
      }
    }
  }
}
