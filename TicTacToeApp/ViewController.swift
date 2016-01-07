
import UIKit

public class ViewController: UIViewController {

  private var game = Game()
  private let gamePrompt = GamePrompt()

  @IBOutlet public weak var infoLabel: UILabel!
  @IBOutlet public var boardButtons: [UIButton]!
  @IBOutlet public weak var resetButton: UIButton!

  override public func viewDidLoad() {
    super.viewDidLoad()
    updateGameInformationDisplay()
    resetButton.enabled = false
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func triggerGameReset() {
    resetGameWithConfirmation()
  }

  @IBAction public func makeMove(button: UIButton) {
    updateGameBoardButtonForPlayerMove(button, playerMark: game.getCurrentPlayer())
    game.makeMove(button.tag)
    updateGameInformationDisplay()

    if (!resetButton.enabled) {
      resetButton.enabled = true
    }

    if game.playerWonLastTurn(game.getInactivePlayer()) {
      disableBoardButtons()
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
    resetButton.enabled = false
    updateGameInformationDisplay()
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

  private func updateGameInformationDisplay() {
    infoLabel.text = gamePrompt.promptFor(game)
  }

  private func updateGameBoardButtonForPlayerMove(button: UIButton, playerMark: PlayerMark) {
    button.setTitle(getButtonTextFor(playerMark), forState: UIControlState.Normal)
    button.enabled = false
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
}
