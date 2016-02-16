import Quick
import Nimble
import TicTacToeApp

class BoardButtonsSpec: QuickSpec {
    override func spec() {

        describe("BoardButtons") {

            func taggedButtons() -> [UIButton] {
                return (0...8).map{ buttonWithTag($0) }
            }

            func buttonWithTag(tag: Int) -> UIButton {
                let button = UIButton()
                button.tag = tag

                return button
            }

            func getButtonFor(space: Int, buttons: [UIButton]) -> UIButton? {
                for button in buttons {
                    if button.tag == space {
                        return button
                    }
                }

                return nil
            }

            func makeMoves(game: Game, moves: [Int]) {
                for move in moves {
                    game.makeMove(move)
                }
            }

            it("marks buttons according to corresponding marks on game board") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                let game = Game()

                game.makeMove(0)
                boardButtons.updateFor(game)

                expect(buttons[0].currentTitle).to(equal(PlayerMark.X.rawValue))
                expect(buttons[1..<buttons.count]).to(allPass({ $0?.currentTitle == nil }))
            }

            it("disables marked buttons") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                let game = Game()

                game.makeMove(0)
                boardButtons.updateFor(game)

                expect(buttons[0].enabled).to(beFalse())
                expect(buttons[1..<buttons.count]).to(allPass({ $0?.enabled == true }))
            }

            it("removes a button's mark if it is not marked on the game  board") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                buttons.forEach{ $0.setTitle("foo", forState: .Normal) }

                boardButtons.updateFor(Game())

                expect(buttons).to(allPass({ $0?.currentTitle == nil }))
            }

            it("enables unmarked buttons") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                buttons.forEach{ $0.enabled = false }

                boardButtons.updateFor(Game())

                expect(buttons).to(allPass({ $0?.enabled == true }))
            }
            
            it("can disable all buttons from being pressed") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                
                boardButtons.disableInput()
                
                expect(buttons).to(allPass{ $0?.enabled == false })
            }

            it("disables all buttons when game is over") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                let game = Game()
                makeMoves(game, moves: [0, 3, 1, 4, 2])

                boardButtons.updateFor(game)

                expect(buttons).to(allPass({ $0?.enabled == false }))
            }
        }
    }
}
