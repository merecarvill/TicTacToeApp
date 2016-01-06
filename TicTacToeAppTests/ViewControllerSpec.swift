import Quick
import Nimble
import TicTacToeApp

class ViewControllerSpec: QuickSpec {
  override func spec() {
    
    var controller: ViewController!
    
    func tagButtonsInSequence(buttons: [UIButton]) {
        var tag = 0
        
        for button in buttons {
            button.tag = tag
            tag += 1
        }
    }
    
    func makeMovesInSequence(controller: ViewController, buttons: [UIButton]) {
        for button in buttons {
            controller.makeMove(button)
        }
    }
    
    beforeEach {
        controller = ViewController()
        controller.boardButtons = [
            UIButton(), UIButton(), UIButton(),
            UIButton(), UIButton(), UIButton(),
            UIButton(), UIButton(), UIButton()
        ]
        tagButtonsInSequence(controller.boardButtons)
    }
    
    describe("ViewController") {

      it("disables button after making a move") {
        let button = controller.boardButtons[0]

        controller.makeMove(button)

        expect(button.enabled).to(beFalse())
      }

      it("changes button title after making a move") {
        let button = controller.boardButtons[0]

        controller.makeMove(button)

        expect(button.currentTitle).notTo(beNil())
      }

      it("changes button title to alternating player marks after each move") {
        let firstMoveButton = controller.boardButtons[0]
        let secondMoveButton = controller.boardButtons[1]
        let thirdMoveButton = controller.boardButtons[2]

        controller.makeMove(firstMoveButton)
        controller.makeMove(secondMoveButton)
        controller.makeMove(thirdMoveButton)

        expect(firstMoveButton.currentTitle).to(equal("X"))
        expect(secondMoveButton.currentTitle).to(equal("O"))
        expect(thirdMoveButton.currentTitle).to(equal("X"))
      }

      it("removes board button titles when the game is reset") {
        controller.boardButtons[0].setTitle("foo", forState: UIControlState.Normal)
        controller.boardButtons[1].setTitle("bar", forState: UIControlState.Normal)

        controller.resetBoard()

        expect(controller.boardButtons[0].currentTitle).to(beNil())
        expect(controller.boardButtons[1].currentTitle).to(beNil())
      }

      it("re-enables pressed board buttons when the game is reset") {
        let pressedButton1 = controller.boardButtons[0]
        let pressedButton2 = controller.boardButtons[1]
        controller.makeMove(pressedButton1)
        controller.makeMove(pressedButton2)

        controller.resetBoard()

        expect(pressedButton1.enabled).to(beTrue())
        expect(pressedButton2.enabled).to(beTrue())
      }

      it("the first player mark is X again after the game is reset") {
        let button = controller.boardButtons[0]
        controller.makeMove(button)
        let initialMark = button.currentTitle

        controller.resetBoard()
        controller.makeMove(button)

        expect(initialMark).to(equal("X"))
        expect(button.currentTitle).to(equal(initialMark))
      }
      
      it("disables all buttons when the game is over") {        
        makeMovesInSequence(controller, buttons: [
                controller.boardButtons[0],
                controller.boardButtons[1],
                controller.boardButtons[3],
                controller.boardButtons[4],
                controller.boardButtons[6]
            ])
    
        expect(controller.boardButtons).to(allPass{ $0!.enabled == false })
      }
    }
  }
}
