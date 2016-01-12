
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
        expect(Game().getCurrentPlayer()).to(equal(PlayerMark.X))
      }

      it("turns alternate between player X and player O") {
        let game = Game()
        let initialPlayer = game.getCurrentPlayer()

        game.makeMove(0)

        expect(initialPlayer).to(equal(PlayerMark.X))
        expect(game.getCurrentPlayer()).to(equal(PlayerMark.O))
      }

      it("has no winning players when just starting a game") {
        expect(Game().playerWonLastTurn(PlayerMark.X)).to(beFalse())
        expect(Game().playerWonLastTurn(PlayerMark.O)).to(beFalse())
      }

      it("reports if player X won") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 6])

        expect(game.playerWonLastTurn(PlayerMark.X)).to(beTrue())
      }

      it("reports if player O won") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 2, 4, 3, 7])

        expect(game.playerWonLastTurn(PlayerMark.O)).to(beTrue())
      }

      it("reports if game is a draw") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 7, 6, 2, 5, 8])

        expect(game.isADraw()).to(beTrue())
      }

      it("reports the marks on the board") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 3, 4, 6])

        let expectedMarks: [PlayerMark?] = [
          PlayerMark.X, PlayerMark.O, PlayerMark.NONE,
          PlayerMark.X, PlayerMark.O, PlayerMark.NONE,
          PlayerMark.X, PlayerMark.NONE, PlayerMark.NONE
        ]

        for spaceId in (0..<expectedMarks.count) {
          expect(game.getBoardMarks()[spaceId]).to(equal(expectedMarks[spaceId]))
        }
      }
    }
  }
}
