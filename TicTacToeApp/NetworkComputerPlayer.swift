import Foundation

public class NetworkComputerPlayer {

    var httpClient: HttpClient?
    let onSuccess: (String) -> Void
    let onFailure: () -> Void
    let serviceUrl = "http://107.170.25.194:5000/api/best_move"

    public init(
        onSuccess: (String) -> Void,
        onFailure: () -> Void
    ) {
        self.onSuccess = onSuccess
        self.onFailure = onFailure
    }

    public func setHttpClient(httpClient: HttpClient) {
        self.httpClient = httpClient
    }

    public func makeMove(gameState: Game) {
        httpClient?.makeRequest(
            assembleUrl(gameState),
            successHandler: onSuccess,
            failureHandler: onFailure
        )
    }

    private func assembleUrl(gameState: Game) -> String {
        let currentPlayer = gameState.getCurrentPlayer().rawValue
        let board = boardToString(gameState.getBoardMarks())

        return "\(serviceUrl)?current_player=\(currentPlayer)&board=\(board))"
    }

    private func boardToString(board: [PlayerMark?]) -> String {
        return board.map{ $0!.rawValue }.joinWithSeparator(",")
    }
}
