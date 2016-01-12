
import UIKit

public class BoardButton: UIButton {
}

public class BoardView: UIView {

  // hypothetical interface
  public func enableInput() {}
  public func disableInput() {}
  public func clear() {}

}

// Refactoring alert dialog
// Might be overkill. Let's revisit after board button refactorings
//public class ConfirmResetGameAlert: UIAlertController {}
// Alternatively, consider builder patter, or just wrapping the alert dialog
//     i.e. composition over inheritance
//public class ConfirmResetGameAlert {
//  var alertController: UIAlertController?
//}

public class ViewController: UIViewController {

  private var game = Game()
  private let gamePrompt = GamePrompt()
  public var currentMode = GameMode.HumanVsHuman

  @IBOutlet public weak var infoLabel: UILabel!
  @IBOutlet public var boardButtons: [UIButton]! // would hyp. live on BoardView
  @IBOutlet public weak var resetButton: UIButton!
  @IBOutlet weak var hvhGameModeButton: UIButton!
  @IBOutlet weak var hvcGameModeButton: UIButton!

  override public func viewDidLoad() {
    super.viewDidLoad()
    updateGamePrompt()
    resetButton.enabled = false
  }

  // Rename to resetGame
  @IBAction public func triggerGameReset() {
    resetGameWithConfirmation()
  }

  @IBAction public func makeMove(button: UIButton) {
    updateGameBoardForPlayerMove(button.tag, playerMark: game.getCurrentPlayer())
    game.makeMove(button.tag)
    updateGamePrompt()

    if (!resetButton.enabled) {
      resetButton.enabled = true
    }

    if game.playerWonLastTurn(game.getInactivePlayer()) || game.isADraw() {
      disableBoardButtons()
    } else if (currentMode == GameMode.HumanVsComputer && game.getCurrentPlayer() == PlayerMark.O) {
      makeMove(getButtonByTag(ComputerPlayer().makeMove(game))!)
    }
  }

  @IBAction public func triggerGameModeChange(button: UIButton) {
    changeGameMode(getModeFrom(button))
  }

  private func changeGameMode(mode: GameMode) {
    if (mode == GameMode.HumanVsHuman) {
      currentMode = GameMode.HumanVsHuman
    } else {
      currentMode = GameMode.HumanVsComputer
    }
  }

  public func resetGameWithConfirmation(confirmationDialogue: UIAlertController =
    UIAlertController(title: "Are you sure?",
      message: "Current game progress will be lost.",
      preferredStyle: UIAlertControllerStyle.Alert)) {
        confirmUserAction(confirmationDialogue, okAction: { self.resetGame() })
  }

  public func resetGame() {
    game = Game()
    clearBoard()
    enableBoardButtons()
    enableResetButton()
    updateGamePrompt()
  }

  private func enableResetButton() {
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

  private func updateGamePrompt() {
    infoLabel.text = gamePrompt.promptFor(game)
  }

  private func updateGameBoardForPlayerMove(spaceId: Int, playerMark: PlayerMark) {
    let button = getButtonByTag(spaceId) ?? UIButton()

    button.setTitle(getButtonTextFor(playerMark), forState: UIControlState.Normal)
    button.enabled = false
  }

  private func getButtonByTag(spaceId: Int) -> UIButton? {
    for button in boardButtons {
      if button.tag == spaceId {
        return button
      }
    }

    return nil
  }

  private func clearBoard() {
    boardButtons.forEach{ $0.setTitle(nil, forState: UIControlState.Normal) }
  }

  private func enableBoardButtons() {
    boardButtons.forEach{ $0.enabled = true }
  }

  private func disableBoardButtons() {
    boardButtons.forEach{ $0.enabled = false }
  }

  private func getButtonTextFor(playerMark: PlayerMark) -> String {
    return playerMark == PlayerMark.X ? "X" : "O"
  }

  private func getModeFrom(button: UIButton) -> GameMode {
    switch button.tag {
      case 0: return GameMode.HumanVsHuman
      case 1: return GameMode.HumanVsComputer
      default: return GameMode.HumanVsHuman
    }
  }
}
