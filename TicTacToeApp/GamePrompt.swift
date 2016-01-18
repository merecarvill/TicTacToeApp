
import UIKit

public class GamePrompt {
  var prompt: UILabel

  public init(prompt: UILabel) {
    self.prompt = prompt
  }

  public func updateFor(game: Game) {
    if game.playerWon(game.getInactivePlayer()) {
      prompt.text = playerWinPrompt(game.getInactivePlayer())
    } else if game.isADraw() {
      prompt.text = playersTiedPrompt()
    } else {
      prompt.text = playerMovePrompt(game.getCurrentPlayer())
    }
  }

  private func playerMovePrompt(playerMark: PlayerMark) -> String {
    return "It's player \(playerMark.rawValue)'s turn:"
  }

  private func playersTiedPrompt() -> String {
    return "Players tied in a draw."
  }

  private func playerWinPrompt(playerMark: PlayerMark) -> String {
    return "Player \(playerMark.rawValue) won!"
  }
}
