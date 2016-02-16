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
            failureHandler: () -> Void)
        {
            lastRequestUrl = url
            if mockResponseBody != nil {
                successHandler(mockResponseBody!)
            } else {
                failureHandler()
            }
        }
    }

    class NullHttpClient: HttpClient {
        internal var lastRequestUrl: String?
        internal var mockResponseBody: String? = ""
        internal var responseHandlers: ((String) -> Void, () -> Void)?

        internal func makeRequest(
            url: String,
            successHandler: (String) -> Void,
            failureHandler: () -> Void)
        { }
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

            it ("has board buttons with tags in sequential order") {
                for i in 0..<controller.boardButtons.count {
                    expect(controller.boardButtons[i].tag).to(equal(i))
                }
            }

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

            it("starts in a human vs human game by default") {
                expect(controller.currentMode).to(equal(GameMode.HumanVsHuman))
            }
            
            it("can change game modes") {
                let humanVsComputerButton = UIButton()
                humanVsComputerButton.tag = GameMode.HumanVsComputer.rawValue
                
                controller.triggerGameModeChange(humanVsComputerButton)
                
                expect(controller.currentMode).to(equal(GameMode.HumanVsComputer))
            }

            describe("human versus computer game") {
            
                it("makes the computer move automatically after player move") {
                    let mockClient = MockHttpClient()
                    mockClient.mockResponseBody = "1"
                    controller.computerPlayer?.setHttpClient(mockClient)
                    controller.currentMode = GameMode.HumanVsComputer

                    controller.makeMove(controller.boardButtons[0])

                    expect(controller.boardButtons[1].currentTitle).toEventuallyNot(beNil())
                }

                it("the computer does not move if the player move ends the game") {
                    let mockClient = MockHttpClient()
                    controller.computerPlayer?.setHttpClient(mockClient)
                    controller.currentMode = GameMode.HumanVsComputer
                    mockClient.mockResponseBody = "3"
                    controller.makeMove(controller.boardButtons[0])
                    mockClient.mockResponseBody = "4"
                    controller.makeMove(controller.boardButtons[1])
                    mockClient.mockResponseBody = "5"

                    controller.makeMove(controller.boardButtons[2])

                    expect(controller.boardButtons[5].currentTitle).to(beNil())
                }

                it("disables input when computer is making a move") {
                    let mockClient = NullHttpClient()
                    mockClient.mockResponseBody = "1"
                    controller.computerPlayer?.setHttpClient(mockClient)
                    controller.currentMode = GameMode.HumanVsComputer

                    controller.makeMove(controller.boardButtons[0])

                    expect(controller.boardButtons).to(allPass({ $0?.enabled == false }))
                }

                it("reenables input when computer is making a move") {
                    let buttons = controller.boardButtons
                    let mockClient = MockHttpClient()
                    mockClient.mockResponseBody = "1"
                    controller.computerPlayer?.setHttpClient(mockClient)
                    controller.currentMode = GameMode.HumanVsComputer

                    controller.makeMove(buttons[0])

                    expect(buttons[0...1]).to(allPass({ $0?.enabled == false }))
                    expect(buttons[2..<buttons.count]).to(allPass({ $0?.enabled == true }))
                }
            }
        }
    }
}
