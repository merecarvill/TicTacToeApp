import UIKit

public class ViewController: UIViewController {

    @IBOutlet public weak var prompt: UILabel!
    @IBOutlet public var boardButtons: [UIButton]!
    @IBOutlet public weak var resetButton: UIButton!
    @IBOutlet var gameModeButtons: [UIButton]!

    private var gameState = Game()
    private var gameBoard: BoardButtons?
    private var gamePrompt: GamePrompt?
    public var currentMode = GameMode.HumanVsHuman
    public var computerPlayer: ComputerPlayer?

    override public func viewDidLoad() {
        super.viewDidLoad()
        computerPlayer = createComputerPlayer()
        gameBoard = BoardButtons(buttons: boardButtons)
        gamePrompt = GamePrompt(prompt: prompt)
        gamePrompt?.updateFor(gameState)
        resetButton.enabled = false
    }

    @IBAction public func makeMove(button: UIButton) {
        gameState.makeMove(button.tag)

        gameBoard?.updateFor(gameState)
        gamePrompt?.updateFor(gameState)
        resetButton.enabled = true

        if isComputerTurn(gameState) && !gameState.isOver() {
            gameBoard?.disableInput()
            computerPlayer!.makeMove(gameState)
        }
    }

    private func isComputerTurn(game: Game) -> Bool {
        return currentMode == GameMode.HumanVsComputer && gameState.getCurrentPlayer() == PlayerMark.O
    }

    private func getCorrespondingButton(space: Int) -> UIButton? {
        return boardButtons.filter{ $0.tag == space }.first
    }

    private func createComputerPlayer() -> ComputerPlayer {
        let computer = ComputerPlayer(
            onSuccess: { move in
                self.makeMove(self.getCorrespondingButton(Int(move)!)!)
            },
            onFailure: {  })
        computer.setHttpClient(AsyncHttpClient())
        return computer
    }

    @IBAction public func resetGameWithConfirmation() {
        let confirmationAlert =
        createAlert("Are you sure?", message: "Current game progress will be lost.")
        addAction(confirmationAlert, title: "OK", action: { (_) in self.resetGame() })
        addAction(confirmationAlert, title: "Cancel", action: { (_) in })

        presentViewController(confirmationAlert, animated: true, completion: nil)
    }

    public func resetGame() {
        gameState = Game()
        gamePrompt?.updateFor(gameState)
        gameBoard?.updateFor(gameState)
        resetButton.enabled = false
    }

    @IBAction public func triggerGameModeChange(button: UIButton) {
        switch button.tag {
        case 0: currentMode = GameMode.HumanVsHuman
        case 1: currentMode = GameMode.HumanVsComputer
        default: currentMode = GameMode.HumanVsHuman
        }
    }

    private func createAlert(title: String, message: String) -> UIAlertController {
        return UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
    }
    
    private func addAction(alertController: UIAlertController, title: String, action: (UIAlertAction) -> Void) {
        alertController.addAction(UIAlertAction(title: title, style: .Default, handler: action))
    }
}
