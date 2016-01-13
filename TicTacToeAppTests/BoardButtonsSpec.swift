
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

      func getButtonBySpaceId(buttons: [UIButton], spaceId: Int) -> UIButton? {
        for button in buttons {
          if button.tag == spaceId {
            return button
          }
        }
        
        return nil
      }

      it("changes the title of the button corresponding to given space") {
        let buttons = taggedButtons()
        let boardButtons = BoardButtons(buttons: buttons)

        boardButtons.markButton("X", spaceId: 0)

        expect(getButtonBySpaceId(buttons, spaceId: 0)?.currentTitle).to(equal("X"))
      }

      it("disables button once it is marked") {
        let buttons = taggedButtons()
        let boardButtons = BoardButtons(buttons: buttons)

        boardButtons.markButton("X", spaceId: 0)

        expect(getButtonBySpaceId(buttons, spaceId: 0)?.enabled).to(beFalse())
      }

      it("can clear the buttons of marks") {
        let buttons = taggedButtons()
        let boardButtons = BoardButtons(buttons: buttons)
        boardButtons.markButton("X", spaceId: 0)
        boardButtons.markButton("O", spaceId: 1)

        boardButtons.clearMarks()

        expect(buttons).to(allPass{ $0?.currentTitle == nil })
      }

      it("enables all buttons when they are cleared of marks") {
        let buttons = taggedButtons()
        let boardButtons = BoardButtons(buttons: buttons)
        boardButtons.markButton("X", spaceId: 0)
        boardButtons.markButton("O", spaceId: 1)

        boardButtons.clearMarks()

        expect(buttons).to(allPass{ $0?.enabled == true })
      }

      it("can disable all buttons from being pressed") {
        let buttons = taggedButtons()
        let boardButtons = BoardButtons(buttons: buttons)

        boardButtons.disable()

        expect(buttons).to(allPass{ $0?.enabled == false })
      }
    }
  }
}
