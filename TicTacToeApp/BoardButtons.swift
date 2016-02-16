import UIKit

public class BoardButtons {
    var buttons: [UIButton]

    public init(buttons: [UIButton]) {
        self.buttons = buttons
    }

    public func updateFor(game: Game) {
        markSpaces(game)
        if game.isOver() {
            disableInput()
        }
    }

    public func disableInput() {
        buttons.forEach{ $0.enabled = false }
    }

    private func markSpaces(game: Game) {
        for (space, mark) in game.getBoardMarks().enumerate() {
            let button = getButtonFor(space)
            if mark != PlayerMark.NONE {
                button?.setTitle(mark?.rawValue, forState: UIControlState.Normal)
                button?.enabled = false
            } else {
                button?.setTitle(nil, forState: UIControlState.Normal)
                button?.enabled = true
            }
        }
    }

    private func getButtonFor(space: Int) -> UIButton? {
        for button in buttons {
            if button.tag == space {
                return button
            }
        }
        return nil
    }
}
