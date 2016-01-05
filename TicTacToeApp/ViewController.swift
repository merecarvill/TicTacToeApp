import UIKit

public class ViewController: UIViewController {
  var currentPlayerMark = "X"

  override public func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override public func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet public var boardButtons: [UIButton]!
  @IBOutlet weak var resetButton: UIButton!

  @IBAction public func resetBoard() {
    boardButtons.forEach{ button in
      button.setTitle(nil, forState: UIControlState.Normal)
      button.enabled = true
    }
    currentPlayerMark = "X"
  }

  @IBAction public func makeMove(button: UIButton) {
    button.setTitle(currentPlayerMark, forState: UIControlState.Normal)
    currentPlayerMark = toggleMark(currentPlayerMark)
    button.enabled = false
  }

  private func toggleMark(mark: String) -> String {
    return mark == "X" ? "O" : "X"
  }
}
