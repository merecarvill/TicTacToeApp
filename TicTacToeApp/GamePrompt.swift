
import UIKit

public class GamePrompt {
  var prompt: UILabel

  public init(prompt: UILabel) {
    self.prompt = prompt
  }

  public func updateFor(game: Game) {
    if game.playerWonLastTurn(game.getInactivePlayer()) {
      prompt.text = playerWinPrompt(game.getInactivePlayer())
    } else if game.isADraw() {
      prompt.text = "Players tied in a draw."
    } else {
      prompt.text = playerMovePrompt(game.getCurrentPlayer())
    }
  }

  private func playerMovePrompt(playerMark: PlayerMark) -> String {
    return "It's player " + playerMark.rawValue + "'s turn:"
  }

  private func playerWinPrompt(playerMark: PlayerMark) -> String {
    return "Player " + playerMark.rawValue + " won!"
  }
}
