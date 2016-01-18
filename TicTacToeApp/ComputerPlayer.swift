
import Foundation

public class ComputerPlayer {

  public init() {}

  public func makeMove(gameState: Game) -> Int {
    var move: Int?
    let serviceUrl = "http://107.170.25.194:5000/"
    let request = computerMoveRequest(gameState, baseUrl: serviceUrl)

    makeBlockingRequest(request, onSuccess: { (data) in move = Int(data) })

    return move ?? getRandomElement(availableSpaces(gameState))
  }

  private func availableSpaces(gameState: Game) -> [Int] {
    let boardMarks = gameState.getBoardMarks()
    var availableSpaces: [Int] = []

    for spaceId in (0..<boardMarks.count) {
      if boardMarks[spaceId] == PlayerMark.NONE {
        availableSpaces.append(spaceId)
      }
    }

    return availableSpaces
  }

  private func getRandomElement(array: [Int]) -> Int {
    return array[Int(arc4random_uniform(UInt32(array.count)))]
  }

  private func makeBlockingRequest(request: NSURLRequest, onSuccess: (String) -> Void) {
    let semaphore = dispatch_semaphore_create(0)

    NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
      guard error == nil && data != nil else {
        dispatch_semaphore_signal(semaphore)
        return
      }

      let reply = String(data: data!, encoding: NSUTF8StringEncoding)
      dispatch_semaphore_signal(semaphore)

      onSuccess(reply!)
    }.resume()
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
  }

  private func computerMoveRequest(gameState: Game, baseUrl: String) -> NSURLRequest {
    let currentPlayerParam = "current_player=" + markToString(gameState.getCurrentPlayer())
    let boardParam = "board=" + boardToString(gameState.getBoardMarks())
    let url = baseUrl + "?" + currentPlayerParam + "&" + boardParam

    return NSURLRequest(URL: NSURL(string: url)!)
  }

  private func boardToString(board: [PlayerMark?]) -> String {
    return board.map{ markToString($0!) }.joinWithSeparator(",")
  }

  private func markToString(mark: PlayerMark) -> String {
    switch (mark) {
    case PlayerMark.NONE: return "_"
    case PlayerMark.X: return "X"
    case PlayerMark.O: return "O"
    }
  }
}
