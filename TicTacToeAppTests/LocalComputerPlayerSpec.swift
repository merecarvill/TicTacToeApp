import Quick
import Nimble
import TicTacToeApp

class LocalComputerPlayerSpec: QuickSpec {
    override func spec() {

        func makeMoves(game: Game, moves: [Int]) {
            for move in moves {
                game.makeMove(move)
            }
        }

        describe("LocalComputerPlayer") {

            it("chooses a move within the bounds of the board") {
                expect(LocalComputerPlayer().makeMove(Game())) >= 0
                expect(LocalComputerPlayer().makeMove(Game())) < 9
            }

            it("only selects moves for unmarked spaces") {
                let game1 = Game()
                makeMoves(game1, moves: [0, 1, 2, 3, 4, 5, 6, 7])
                let game2 = Game()
                makeMoves(game2, moves: [1, 2, 3, 4, 5, 6, 7, 8])

                expect(LocalComputerPlayer().makeMove(game1)).to(equal(8))
                expect(LocalComputerPlayer().makeMove(game2)).to(equal(0))
            }
        }
    }
}
