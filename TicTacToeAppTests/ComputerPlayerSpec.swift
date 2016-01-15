
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

      it("chooses a move within the bounds of the board") {
        expect(ComputerPlayer().makeMove(Game())) >= 0
        expect(ComputerPlayer().makeMove(Game())) < 9
      }

      it("only selects moves for unmarked spaces") {
        let game1 = Game()
        makeSequenceOfMoves(game1, moves: [0, 1, 2, 3, 4, 5, 6, 7])
        let game2 = Game()
        makeSequenceOfMoves(game2, moves: [1, 2, 3, 4, 5, 6, 7, 8])

        expect(ComputerPlayer().makeMove(game1)).to(equal(8))
        expect(ComputerPlayer().makeMove(game2)).to(equal(0))
      }
    }
  }
}
