import Quick
import Nimble
import TicTacToeApp

class ViewControllerSpec: QuickSpec {

  override func setUp() {
    continueAfterFailure = false
  }

  override func spec() {
    
    var controller: ViewController!
    var infoLabel: UILabel!
    
    func tagButtonsInSequence(buttons: [UIButton]) {
      var tag = 0
        
      for button in buttons {
          button.tag = tag
          tag += 1
      }
    }
    
    func makeMovesInSequence(controller: ViewController, buttonSequence: [Int]) {
      for buttonIndex in buttonSequence {
          controller.makeMove(controller.boardButtons[buttonIndex])
      }
    }

    beforeEach {
      controller = ViewController()
      infoLabel = UILabel()
      controller.infoLabel = infoLabel
      controller.boardButtons = [
          UIButton(), UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton(),
          UIButton(), UIButton(), UIButton()
      ]
      tagButtonsInSequence(controller.boardButtons)
      controller.viewDidLoad()
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
        makeMovesInSequence(controller, buttonSequence: [0, 1, 3, 4, 6])
    
        expect(controller.boardButtons).to(allPass{ $0!.enabled == false })
      }

      it("informs player X that it's their turn when the game starts") {
        expect(controller.infoLabel.text).to(equal("It's player X's turn:"))
      }

      it("informs player O that it's their turn after player X makes their move") {
        controller.makeMove(controller.boardButtons[0])

        expect(controller.infoLabel.text).to(equal("It's player O's turn:"))
      }

      it("informs player X that it's their turn after game restart") {
        makeMovesInSequence(controller, buttonSequence: [0, 1, 3, 4, 6])

        controller.resetBoard()

        expect(controller.infoLabel.text).to(equal("It's player X's turn:"))
      }

      it("informs winning player X that they won") {
        makeMovesInSequence(controller, buttonSequence: [0, 1, 3, 4, 6])

        expect(controller.infoLabel.text).to(equal("Player X won!"))
      }

      it("informs winning player O that they won") {
        makeMovesInSequence(controller, buttonSequence: [2, 0, 1, 3, 4, 6])


        expect(controller.infoLabel.text).to(equal("Player O won!"))
      }

      it("informs players of a draw") {
        makeMovesInSequence(controller, buttonSequence: [0, 1, 3, 4, 7, 6, 2, 5, 8])

        expect(controller.infoLabel.text).to(equal("Players tied in a draw."))
      }
    }
  }
}
