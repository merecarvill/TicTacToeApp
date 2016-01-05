import UIKit

public class ViewController: UIViewController {

  override public func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private var game = Game()

  @IBOutlet public var boardButtons: [UIButton]!
  @IBOutlet weak var resetButton: UIButton!

  @IBAction public func resetBoard() {
    clearBoard()
    enableBoardButtons()
    game = Game()
  }

  @IBAction public func makeMove(button: UIButton) {
    button.setTitle(getMarkFor(game.getCurrentPlayer()), forState: UIControlState.Normal)
    button.enabled = false
    game.makeMove(button.tag)
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
}
