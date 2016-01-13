
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

  override public func viewDidLoad() {
    super.viewDidLoad()
    gameBoard = BoardButtons(buttons: boardButtons)
    gamePrompt = GamePrompt(prompt: prompt)
    gamePrompt?.updateFor(gameState)
    resetButton.enabled = false
  }

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
    switch button.tag {
      case 0: currentMode = GameMode.HumanVsHuman
      case 1: currentMode = GameMode.HumanVsComputer
      default: currentMode = GameMode.HumanVsHuman
    }
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
}
