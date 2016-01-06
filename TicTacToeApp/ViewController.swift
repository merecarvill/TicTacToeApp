import UIKit

public class ViewController: UIViewController {

  private var game = Game()

  @IBOutlet public weak var infoLabel: UILabel!
  @IBOutlet public var boardButtons: [UIButton]!
  @IBOutlet weak var resetButton: UIButton!

  override public func viewDidLoad() {
    super.viewDidLoad()
    informPlayerMove(game.getCurrentPlayer())
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction public func resetBoard() {
    clearBoard()
    enableBoardButtons()
    game = Game()
    informPlayerMove(game.getCurrentPlayer())
  }

  @IBAction public func makeMove(button: UIButton) {
    let playerThatMoved = game.getCurrentPlayer()
    button.setTitle(getMarkFor(game.getCurrentPlayer()), forState: UIControlState.Normal)
    button.enabled = false
    game.makeMove(button.tag)
    updatePlayerInformation(playerThatMoved, gameState: game)
    
    if game.playerWonLastTurn(playerThatMoved) {
      disableBoardButtons()
    }
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

  private func getMarkFor(player: Int) -> String {
    return player == Board.X ? "X" : "O"
  }

  private func updatePlayerInformation(playerThatMoved: Int, gameState: Game) {
    if game.playerWonLastTurn(playerThatMoved) {
      informPlayerWon(playerThatMoved)
    } else if game.isADraw() {
      informGameDraw()
    } else {
      informPlayerMove(game.getCurrentPlayer())
    }
  }

  private func informPlayerMove(player: Int) {
    infoLabel.text = "It's player " + getMarkFor(player) + "'s turn:"
  }

  private func informPlayerWon(player: Int) {
    infoLabel.text = "Player " + getMarkFor(player) + " won!"
  }

  private func informGameDraw() {
    infoLabel.text = "Players tied in a draw."
  }
}
