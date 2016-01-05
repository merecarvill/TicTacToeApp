import Quick
import Nimble
import TicTacToeApp

class GameSpec: QuickSpec {
  override func spec() {

    describe("Game") {

      it("is not over to start") {
        expect(Game().isOver()).to(beFalse())
      }

      it ("starts the game with the first player as the current player") {
        expect(Game().getCurrentPlayer()).to(equal(Game.Player.First))
      }

      it("alternates the current player") {
        let game = Game()
        let initialPlayer = game.getCurrentPlayer()

        game.makeMove(0)

        expect(initialPlayer).to(equal(Game.Player.First))
        expect(game.getCurrentPlayer()).to(equal(Game.Player.Second))
      }
    }
  }
}
