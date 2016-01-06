
import UIKit

public class ViewController: UIViewController {

  private var game = Game()
  private let gamePrompt = GamePrompt()

  @IBOutlet public weak var infoLabel: UILabel!
  @IBOutlet public var boardButtons: [UIButton]!
  @IBOutlet weak var resetButton: UIButton!

  override public func viewDidLoad() {
    super.viewDidLoad()
    updateGameInformationDisplay()
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction public func resetBoard() {
    clearBoard()
    enableBoardButtons()
    game = Game()
    updateGameInformationDisplay()
  }

  @IBAction public func makeMove(button: UIButton) {
    updateGameBoardButtonForPlayerMove(button, playerMark: game.getCurrentPlayer())
    game.makeMove(button.tag)
    updateGameInformationDisplay()

    if game.playerWonLastTurn(game.getInactivePlayer()) {
      disableBoardButtons()
    }
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
