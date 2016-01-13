
import UIKit

public class GamePrompt {
  var prompt: UILabel

  public init() {
    self.prompt = UILabel()
  }

  public init(prompt: UILabel) {
    self.prompt = prompt
  }

  public func updateFor(game: Game) -> String {
    if game.playerWonLastTurn(game.getInactivePlayer()) {
      prompt.text = playerWinPrompt(game.getInactivePlayer())
      return prompt.text!
    } else if game.isADraw() {
      prompt.text = "Players tied in a draw."
      return prompt.text!
    } else {
      prompt.text = playerMovePrompt(game.getCurrentPlayer())
      return prompt.text!
    }
  }

  private func playerMovePrompt(playerMark: PlayerMark) -> String {
    return "It's player " + playerMark.rawValue + "'s turn:"
  }

  private func playerWinPrompt(playerMark: PlayerMark) -> String {
    return "Player " + playerMark.rawValue + " won!"
  }
}
