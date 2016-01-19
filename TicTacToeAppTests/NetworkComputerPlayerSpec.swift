import Quick
import Nimble
import TicTacToeApp

class NetworkComputerPlayerSpec: QuickSpec {

    class MockHttpClient: HttpClient {
        internal var lastRequestUrl: String?
        internal var mockResponseBody: String? = ""

        internal func makeRequest(
            url: String,
            successHandler: (String) -> Void,
            failureHandler: () -> Void
        ) {
            lastRequestUrl = url
            if mockResponseBody != nil {
                successHandler(mockResponseBody!)
            } else {
                failureHandler()
            }
        }
    }

    override func spec() {

        func makeMoves(game: Game, moveSequence: [Int]) {
            for spaceId in moveSequence {
                game.makeMove(spaceId)
            }
        }

        describe("NetworkComputerPlayer") {

            it("knows the root url from which to construct requests for the http client") {
                let serviceUrl = "http://107.170.25.194:5000/"
                let httpClient = MockHttpClient()
                let computer = NetworkComputerPlayer(
                    httpClient: httpClient,
                    onSuccess: { _ in },
                    onFailure: { _ in }
                )

                computer.makeMove(Game())

                expect(httpClient.lastRequestUrl).to(beginWith(serviceUrl))
            }

            it("makes a request to an http client with current player as a parameter") {
                let httpClient = MockHttpClient()
                let computer = NetworkComputerPlayer(
                    httpClient: httpClient,
                    onSuccess: { _ in },
                    onFailure: { _ in }
                )

                computer.makeMove(Game())

                expect(httpClient.lastRequestUrl).to(contain("current_player=\(PlayerMark.X.rawValue)"))
            }

            it("makes a request to an http client with the board as a parameter") {
                let x = PlayerMark.X.rawValue
                let o = PlayerMark.O.rawValue
                let blank = PlayerMark.NONE.rawValue
                let game = Game()
                makeMoves(game, moveSequence: [0, 1, 2, 3, 4, 5, 6, 7])
                let boardString = "board=\(x),\(o),\(x),\(o),\(x),\(o),\(x),\(o),\(blank)"
                let httpClient = MockHttpClient()
                let computer = NetworkComputerPlayer(
                    httpClient: httpClient,
                    onSuccess: { _ in },
                    onFailure: { _ in }
                )

                computer.makeMove(game)

                expect(httpClient.lastRequestUrl).to(contain(boardString))
            }

            it("passes http client response body to success handler if response has body") {
                let httpClient = MockHttpClient()
                httpClient.mockResponseBody = "body"
                var successHandlerTarget: String?
                let computer = NetworkComputerPlayer(
                    httpClient: httpClient,
                    onSuccess: { responseData in successHandlerTarget = responseData },
                    onFailure: { _ in }
                )

                computer.makeMove(Game())

                expect(successHandlerTarget).to(equal(httpClient.mockResponseBody))
            }

            it("calls failure handler if http client response has no body") {
                let httpClient = MockHttpClient()
                httpClient.mockResponseBody = nil
                var failureHandlerTarget = "has not been called"
                let computer = NetworkComputerPlayer(
                    httpClient: httpClient,
                    onSuccess: { _ in },
                    onFailure: { failureHandlerTarget = "was called" }
                )

                computer.makeMove(Game())

                expect(failureHandlerTarget).to(equal("was called"))
            }
        }
    }
}
