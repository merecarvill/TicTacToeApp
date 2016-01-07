
import Quick
import Nimble
import TicTacToeApp

class ComputerPlayerSpec: QuickSpec {
  override func spec() {

    func makeSequenceOfMoves(game: Game, moves: [Int]) {
      for move in moves {
        game.makeMove(move)
      }
    }

    describe("ComputerPlayer") {

      it("chooses a move given a game state") {
        expect(ComputerPlayer().makeMove(Game())) >= 0
        expect(ComputerPlayer().makeMove(Game())) < 9
      }

      it("only selects moves for unmarked spaces") {
        let game = Game()
        makeSequenceOfMoves(game, moves: [0, 1, 2, 3, 4, 5, 6, 7])

        expect(ComputerPlayer().makeMove(game)).to(equal(8))
      }
    }

  }
}