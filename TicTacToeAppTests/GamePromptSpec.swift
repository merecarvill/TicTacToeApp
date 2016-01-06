
import Quick
import Nimble
import TicTacToeApp

class GamePromptSpec: QuickSpec {
  override func spec() {

    func makeMovesInSequence(game: Game, moveSequence: [Int]) {
      for spaceId in moveSequence {
        game.makeMove(spaceId)
      }
    }

    describe("GamePrompt") {
      it("informs player X that it's their turn when the game starts") {
        expect(GamePrompt().promptFor(Game())).to(equal("It's player X's turn:"))
      }

      it("informs player O that it's their turn after player X makes their move") {
        let game = Game()

        game.makeMove(0)

        expect(GamePrompt().promptFor(game)).to(equal("It's player O's turn:"))
      }

      it("informs winning player X that they won") {
        let game = Game()
        makeMovesInSequence(game, moveSequence: [0, 1, 3, 4, 6])

        expect(GamePrompt().promptFor(game)).to(equal("Player X won!"))
      }

      it("informs winning player O that they won") {
        let game = Game()
        makeMovesInSequence(game, moveSequence: [2, 0, 1, 3, 4, 6])

        expect(GamePrompt().promptFor(game)).to(equal("Player O won!"))
      }

      it("informs players of a draw") {
        let game = Game()
        makeMovesInSequence(game, moveSequence: [0, 1, 3, 4, 7, 6, 2, 5, 8])

        expect(GamePrompt().promptFor(game)).to(equal("Players tied in a draw."))
      }
    }
  }
}
