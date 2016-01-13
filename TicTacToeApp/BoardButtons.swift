
import UIKit

public class BoardButtons {
  var buttons: [UIButton]

  public init(buttons: [UIButton]) {
    self.buttons = buttons
  }

  public func markButton(playerMark: PlayerMark, spaceId: Int) {
    let button = getButtonBySpaceId(spaceId)
    button?.setTitle(playerMark.rawValue, forState: UIControlState.Normal)
    button?.enabled = false
  }

  public func clearMarks() {
    for button in buttons {
      button.setTitle(nil, forState: UIControlState.Normal)
      button.enabled = true
    }
  }

  public func disableInput() {
    buttons.forEach{ $0.enabled = false }
  }

  private func getButtonBySpaceId(spaceId: Int) -> UIButton? {
    for button in buttons {
      if button.tag == spaceId {
        return button
      }
    }
    return nil
  }
}
