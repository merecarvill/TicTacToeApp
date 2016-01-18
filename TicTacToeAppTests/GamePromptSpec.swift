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
                let prompt = UILabel()

                GamePrompt(prompt: prompt).updateFor(Game())

                expect(prompt.text).to(equal("It's player X's turn:"))
            }

            it("informs player O that it's their turn after player X makes their move") {
                let prompt = UILabel()
                let gameState = Game()
                gameState.makeMove(0)

                GamePrompt(prompt: prompt).updateFor(gameState)

                expect(prompt.text).to(equal("It's player O's turn:"))
            }

            it("informs winning player X that they won") {
                let prompt = UILabel()
                let gameState = Game()
                makeMovesInSequence(gameState, moveSequence: [0, 1, 3, 4, 6])

                GamePrompt(prompt: prompt).updateFor(gameState)

                expect(prompt.text).to(equal("Player X won!"))
            }

            it("informs winning player O that they won") {
                let prompt = UILabel()
                let gameState = Game()
                makeMovesInSequence(gameState, moveSequence: [2, 0, 1, 3, 4, 6])

                GamePrompt(prompt: prompt).updateFor(gameState)

                expect(prompt.text).to(equal("Player O won!"))
            }
            
            it("informs players of a draw") {
                let prompt = UILabel()
                let gameState = Game()
                makeMovesInSequence(gameState, moveSequence: [0, 1, 3, 4, 7, 6, 2, 5, 8])
                
                GamePrompt(prompt: prompt).updateFor(gameState)
                
                expect(prompt.text).to(equal("Players tied in a draw."))
            }
        }
    }
}
