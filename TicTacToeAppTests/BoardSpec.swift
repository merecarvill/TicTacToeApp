import Quick
import Nimble
import TicTacToeApp

class BoardSpec: QuickSpec {
    override func spec() {

        describe("Board") {

            it("is unmarked to start") {
                let board = Board()

                expect(board.readSpace(0)).to(equal(PlayerMark.NONE))
            }

            it("records a player's mark") {
                var board = Board()

                board = board.markSpace(0, mark: .X)

                expect(board.readSpace(0)).to(equal(PlayerMark.X))
            }

            it("does not have a winning line to start") {
                let board = Board()

                expect(board.hasWinningLine()).to(beFalse())
            }

            it("has a winning line when a line is all the same player's mark") {
                let board = Board(markedSpaces: [0 : .X, 1 : .X, 2 : .X])

                expect(board.hasWinningLine()).to(beTrue())
            }

            it("there are open spaces in a new game") {
                expect(Board().isFull()).to(beFalse())
            }

            it("can tell you the number of total spaces") {
                expect(Board().numberOfSpaces()).to(equal(9))
            }
            
            it("reports whether all spaces have been marked") {
                let board = Board(markedSpaces: [
                    0 : .X, 1 : .O, 2 : .X,
                    3 : .X, 4 : .O, 5 : .X,
                    6 : .O, 7 : .X, 8 : .O
                    ])
                
                expect(board.isFull()).to(beTrue())
            }
        }
    }
}
