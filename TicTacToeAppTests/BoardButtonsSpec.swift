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

            it("changes the title of the button corresponding to given space") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)

                boardButtons.markButton(.X, space: 0)

                expect(getButtonFor(0, buttons: buttons)?.currentTitle).to(equal("X"))
            }

            it("disables button once it is marked") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)

                boardButtons.markButton(.X, space: 0)

                expect(getButtonFor(0, buttons: buttons)?.enabled).to(beFalse())
            }

            it("can clear the buttons of marks") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                boardButtons.markButton(.X, space: 0)
                boardButtons.markButton(.O, space: 1)

                boardButtons.clearMarks()

                expect(buttons).to(allPass{ $0?.currentTitle == nil })
            }

            it("enables all buttons when they are cleared of marks") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                boardButtons.markButton(.X, space: 0)
                boardButtons.markButton(.O, space: 1)
                
                boardButtons.clearMarks()
                
                expect(buttons).to(allPass{ $0?.enabled == true })
            }
            
            it("can disable all buttons from being pressed") {
                let buttons = taggedButtons()
                let boardButtons = BoardButtons(buttons: buttons)
                
                boardButtons.disableInput()
                
                expect(buttons).to(allPass{ $0?.enabled == false })
            }
        }
    }
}
