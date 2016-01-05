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
    }
  }
}