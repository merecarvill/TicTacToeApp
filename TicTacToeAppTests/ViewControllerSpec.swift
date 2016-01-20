import Quick
import Nimble
import TicTacToeApp

class ViewControllerSpec: QuickSpec {

    class MockHttpClient: HttpClient {
        internal var lastRequestUrl: String?
        internal var mockResponseBody: String? = ""

        internal func makeRequest(
            url: String,
            successHandler: (String) -> Void,
            failureHandler: () -> Void
            ) {
                lastRequestUrl = url
                if mockResponseBody != nil {
                    successHandler(mockResponseBody!)
                } else {
                    failureHandler()
                }
        }
    }

    override func setUp() {
        continueAfterFailure = false
    }

    override func spec() {

        var controller: ViewController!
        var prompt: UILabel!
        var resetButton: UIButton!
        let firstPlayerMark = PlayerMark.X.rawValue
        let secondPlayerMark = PlayerMark.O.rawValue

        func tagButtonsInSequence(buttons: [UIButton]) {
            var tag = 0

            for button in buttons {
                button.tag = tag
                tag += 1
            }
        }

        func makeMoves(controller: ViewController, buttonSequence: [Int]) {
            for buttonIndex in buttonSequence {
                controller.makeMove(controller.boardButtons[buttonIndex])
            }
        }

        beforeEach {
            controller = ViewController()
            prompt = UILabel()
            resetButton = UIButton()
            controller.prompt = prompt
            controller.boardButtons = [
                UIButton(), UIButton(), UIButton(),
                UIButton(), UIButton(), UIButton(),
                UIButton(), UIButton(), UIButton()
            ]
            controller.resetButton = resetButton
            tagButtonsInSequence(controller.boardButtons)
            controller.viewDidLoad()
        }

        describe("ViewController") {

            it("marks the first pressed button with the first player's mark") {
                let firstMoveButton = controller.boardButtons[0]

                controller.makeMove(firstMoveButton)

                expect(firstMoveButton.currentTitle).to(equal(firstPlayerMark))
            }

            it("marks the second pressed button with the second player's mark") {
                let secondMoveButton = controller.boardButtons[1]

                makeMoves(controller, buttonSequence: [0, 1])

                expect(secondMoveButton.currentTitle).to(equal(secondPlayerMark))
            }

            it("alternates between first and second player mark for subsequent button presses") {
                let thirdMoveButton = controller.boardButtons[2]
                let fourthMoveButton = controller.boardButtons[3]

                makeMoves(controller, buttonSequence: [0, 1, 2, 3])

                expect(thirdMoveButton.currentTitle).to(equal(firstPlayerMark))
                expect(fourthMoveButton.currentTitle).to(equal(secondPlayerMark))

            }

            it("disables reset button when no moves have been made") {
                expect(resetButton.enabled).to(beFalse())
            }

            it("enables reset button when one or more moves have been made") {
                makeMoves(controller, buttonSequence: [0])

                expect(resetButton.enabled).to(beTrue())
            }

            it("disables reset button after game reset") {
                resetButton.enabled = true

                controller.resetGame()

                expect(resetButton.enabled).to(beFalse())
            }

            it("removes board button titles when the game is reset") {
                makeMoves(controller, buttonSequence: [0, 1, 2, 3, 4, 5, 6, 7, 8])

                controller.resetGame()

                expect(controller.boardButtons).to(allPass{ $0!.currentTitle == nil })

            }

            it("re-enables board buttons when the game is reset") {
                makeMoves(controller, buttonSequence: [0, 1, 2, 3, 4, 5, 6, 7, 8])

                controller.resetGame()

                expect(controller.boardButtons).to(allPass{ $0!.enabled })
            }

            it("the first player goes first again after the game is reset") {
                makeMoves(controller, buttonSequence: [0])
                let initialMark = controller.boardButtons[0].currentTitle

                controller.resetGame()
                makeMoves(controller, buttonSequence: [0])

                expect(initialMark).to(equal(firstPlayerMark))
                expect(controller.boardButtons[0].currentTitle).to(equal(initialMark))
            }

            it("disables all board buttons when the game is won") {
                makeMoves(controller, buttonSequence: [0, 1, 3, 4, 6])

                expect(controller.boardButtons).to(allPass{ $0!.enabled == false })
            }

            it("disables all board buttons when the game ends in a draw") {
                makeMoves(controller, buttonSequence: [0, 1, 3, 4, 7, 6, 2, 5, 8])

                expect(controller.boardButtons).to(allPass{ $0!.enabled == false })
            }

            it("informs player X that it's their turn when the game starts") {
                expect(controller.prompt.text).to(equal("It's player X's turn:"))
            }

            it("informs player O that it's their turn after player X makes their move") {
                controller.makeMove(controller.boardButtons[0])

                expect(controller.prompt.text).to(equal("It's player O's turn:"))
            }

            it("informs player X that it's their turn after game restart") {
                makeMoves(controller, buttonSequence: [0, 1, 3, 4, 6])

                controller.resetGame()

                expect(controller.prompt.text).to(equal("It's player X's turn:"))
            }

            it("informs winning player X that they won") {
                makeMoves(controller, buttonSequence: [0, 1, 3, 4, 6])

                expect(controller.prompt.text).to(equal("Player X won!"))
            }
            
            it("informs winning player O that they won") {
                makeMoves(controller, buttonSequence: [2, 0, 1, 3, 4, 6])
                
                
                expect(controller.prompt.text).to(equal("Player O won!"))
            }
            
            it("informs players of a draw") {
                makeMoves(controller, buttonSequence: [0, 1, 3, 4, 7, 6, 2, 5, 8])
                
                expect(controller.prompt.text).to(equal("Players tied in a draw."))
            }
            
            it("starts in a human vs human game by default") {
                expect(controller.currentMode).to(equal(GameMode.HumanVsHuman))
            }
            
            it("can change game modes") {
                let humanVsComputerButton = UIButton()
                humanVsComputerButton.tag = GameMode.HumanVsComputer.rawValue
                
                controller.triggerGameModeChange(humanVsComputerButton)
                
                expect(controller.currentMode).to(equal(GameMode.HumanVsComputer))
            }
            
            it("makes the computer move automatically after player move") {
                let mockClient = MockHttpClient()
                mockClient.mockResponseBody = "1"
                controller.computerPlayer?.setHttpClient(mockClient)
                controller.currentMode = GameMode.HumanVsComputer
                
                controller.makeMove(controller.boardButtons[0])

                expect(controller.boardButtons[1].currentTitle).toEventuallyNot(beNil())
            }
        }
    }
}
