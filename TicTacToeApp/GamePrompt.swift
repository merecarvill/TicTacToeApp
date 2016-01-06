
public class GamePrompt {

  public init() {

  }

  public func promptFor(game: Game) -> String {
    if game.playerWonLastTurn(game.getInactivePlayer()) {
      return playerWinPrompt(game.getInactivePlayer())
    } else if game.isADraw() {
      return "Players tied in a draw."
    } else {
      return playerMovePrompt(game.getCurrentPlayer())
    }
  }

  private func playerMovePrompt(playerMark: PlayerMark) -> String {
    return "It's player " + playerMarkToString(playerMark) + "'s turn:"
  }

  private func playerWinPrompt(playerMark: PlayerMark) -> String {
    return "Player " + playerMarkToString(playerMark) + " won!"
  }

  private func playerMarkToString(player: PlayerMark) -> String {
    return player == PlayerMark.X ? "X" : "O"
  }
}
