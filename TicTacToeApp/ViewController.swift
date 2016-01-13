
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
  public var confirmationAlert: UIAlertController?


  override public func viewDidLoad() {
    super.viewDidLoad()
    gameBoard = BoardButtons(buttons: boardButtons)
    gamePrompt = GamePrompt(prompt: prompt)
    confirmationAlert = createAlert("Are you sure?", message: "Current game progress will be lost.")
    gamePrompt?.updateFor(gameState)
    resetButton.enabled = false
  }

  @IBAction public func makeMove(button: UIButton) {
    gameBoard?.markButton(gameState.getCurrentPlayer(), spaceId: button.tag)

    gameState.makeMove(button.tag)
    gamePrompt?.updateFor(gameState)
    resetButton.enabled = true

    if gameIsOver(gameState) {
      gameBoard?.disableInput()
    } else if isComputersTurn(gameState) {
      makeMove(getCorrespondingButton(ComputerPlayer().makeMove(gameState))!)
    }
  }

  private func gameIsOver(game: Game) -> Bool {
    return gameState.playerWonLastTurn(game.getInactivePlayer()) || game.isADraw()
  }

  private func isComputersTurn(game: Game) -> Bool {
    return currentMode == GameMode.HumanVsComputer && gameState.getCurrentPlayer() == PlayerMark.O
  }

  private func getCorrespondingButton(spaceId: Int) -> UIButton? {
    for button in boardButtons {
      if button.tag == spaceId {
        return button
      }
    }
    return nil
  }

  @IBAction public func resetGameWithConfirmation() {
    if userConfirmsAction(confirmationAlert!) {
      resetGame()
    }
  }

  public func resetGame() {
    gameState = Game()
    gamePrompt?.updateFor(gameState)
    gameBoard?.clearMarks()
    resetButton.enabled = false
  }

  private func userConfirmsAction(confirmationAlert: UIAlertController) -> Bool {
    var actionConfirmed = false
    addAction(confirmationAlert, title: "OK", action: { (_) in actionConfirmed = true })
    addAction(confirmationAlert, title: "Cancel", action: { (_) in })

    presentViewController(confirmationAlert, animated: true, completion: nil)

    return actionConfirmed
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
