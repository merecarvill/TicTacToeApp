
import UIKit

// Refactoring alert dialog
// Might be overkill. Let's revisit after board button refactorings
//public class ConfirmResetGameAlert: UIAlertController {}
// Alternatively, consider builder patter, or just wrapping the alert dialog
//     i.e. composition over inheritance
//public class ConfirmResetGameAlert {
//  var alertController: UIAlertController?
//}

public class ViewController: UIViewController {

  @IBOutlet public weak var prompt: UILabel!
  @IBOutlet public var boardButtons: [UIButton]!
  @IBOutlet public weak var resetButton: UIButton!
  @IBOutlet weak var hvhGameModeButton: UIButton!
  @IBOutlet weak var hvcGameModeButton: UIButton!

  private var gameState = Game()
  private var gameBoard: BoardButtons?
  private var gamePrompt: GamePrompt?
  public var currentMode = GameMode.HumanVsHuman

  override public func viewDidLoad() {
    super.viewDidLoad()
    gameBoard = BoardButtons(buttons: boardButtons)
    gamePrompt = GamePrompt(prompt: prompt)
    gamePrompt?.updateFor(gameState)
    resetButton.enabled = false
  }

  // Rename to resetGame
  @IBAction public func triggerGameReset() {
    resetGameWithConfirmation()
  }

  @IBAction public func makeMove(button: UIButton) {
    gameBoard?.markButton(gameState.getCurrentPlayer(), spaceId: button.tag)

    gameState.makeMove(button.tag)
    gamePrompt?.updateFor(gameState)
    resetButton.enabled = true

    if gameState.playerWonLastTurn(gameState.getInactivePlayer()) || gameState.isADraw() {
      gameBoard?.disableInput()
    } else if (currentMode == GameMode.HumanVsComputer && gameState.getCurrentPlayer() == PlayerMark.O) {
      makeMove(getCorrespondingButton(ComputerPlayer().makeMove(gameState))!)
    }
  }

  @IBAction public func triggerGameModeChange(button: UIButton) {
    changeGameMode(getModeFrom(button))
  }

  public func resetGameWithConfirmation(confirmationDialogue: UIAlertController =
    UIAlertController(title: "Are you sure?",
      message: "Current game progress will be lost.",
      preferredStyle: UIAlertControllerStyle.Alert)) {
        confirmUserAction(confirmationDialogue, okAction: { self.resetGame() })
  }

  public func resetGame() {
    gameState = Game()
    gamePrompt?.updateFor(gameState)
    gameBoard?.clearMarks()
    resetButton.enabled = false
  }

  private func changeGameMode(mode: GameMode) {
    if (mode == GameMode.HumanVsHuman) {
      currentMode = GameMode.HumanVsHuman
    } else {
      currentMode = GameMode.HumanVsComputer
    }
  }

  private func confirmUserAction(confirmationDialogue: UIAlertController, okAction: () -> Void ) {
    addAlertAction(confirmationDialogue, title: "OK", action: {(action: UIAlertAction!) in
      okAction()
    })
    addAlertAction(confirmationDialogue, title: "Cancel", action: {(_) in })

    presentViewController(confirmationDialogue, animated: true, completion: nil)
  }

  private func addAlertAction(alertController: UIAlertController, title: String, action: (UIAlertAction) -> Void) {
    alertController.addAction(UIAlertAction(title: title, style: .Default, handler: action))
  }

  private func getCorrespondingButton(spaceId: Int) -> UIButton? {
    for button in boardButtons {
      if button.tag == spaceId {
        return button
      }
    }

    return nil
  }

  private func getModeFrom(button: UIButton) -> GameMode {
    switch button.tag {
      case 0: return GameMode.HumanVsHuman
      case 1: return GameMode.HumanVsComputer
      default: return GameMode.HumanVsHuman
    }
  }
}
