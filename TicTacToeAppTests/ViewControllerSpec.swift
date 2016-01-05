import Quick
import Nimble
import TicTacToeApp

class ViewControllerSpec: QuickSpec {
  override func spec() {

    describe("ViewController") {

      it("disables button after making a move") {
        let controller = ViewController()
        let button = UIButton()

        controller.makeMove(button)

        expect(button.enabled).to(beFalse())
      }

      it("changes button title after making a move") {
        let controller = ViewController()
        let button = UIButton()

        controller.makeMove(button)

        expect(button.currentTitle).notTo(beNil())
      }

      it("changes button title to alternating player marks after each move") {
        let controller = ViewController()
        let firstMoveButton = UIButton()
        let secondMoveButton = UIButton()
        let thirdMoveButton = UIButton()

        controller.makeMove(firstMoveButton)
        controller.makeMove(secondMoveButton)
        controller.makeMove(thirdMoveButton)

        expect(firstMoveButton.currentTitle).to(equal("X"))
        expect(secondMoveButton.currentTitle).to(equal("O"))
        expect(thirdMoveButton.currentTitle).to(equal("X"))
      }

      it("removes board button titles when the game is reset") {
        let controller = ViewController()
        controller.boardButtons = [
          UIButton(), UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton()
        ]

        controller.boardButtons[0].setTitle("foo", forState: UIControlState.Normal)
        controller.boardButtons[1].setTitle("bar", forState: UIControlState.Normal)

        controller.resetBoard()

        expect(controller.boardButtons[0].currentTitle).to(beNil())
        expect(controller.boardButtons[1].currentTitle).to(beNil())
      }

      it("reenables pressed board buttons when the game is reset") {
        let controller = ViewController()
        let pressedButton1 = UIButton()
        let pressedButton2 = UIButton()

        controller.makeMove(pressedButton1)
        controller.makeMove(pressedButton2)

        controller.boardButtons = [
          pressedButton1, pressedButton2, UIButton(),
          UIButton(), UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton()
        ]

        controller.resetBoard()

        expect(pressedButton1.enabled).to(beTrue())
        expect(pressedButton2.enabled).to(beTrue())
      }

      it("the first player mark is X again after the game is reset") {
        let controller = ViewController()
        let button = UIButton()

        controller.boardButtons = [
          button, UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton()
        ]
        controller.makeMove(button)

        let initialMark = button.currentTitle

        controller.resetBoard()
        controller.makeMove(button)

        expect(initialMark).to(equal("X"))
        expect(button.currentTitle).to(equal(initialMark))
      }
    }
  }
}
