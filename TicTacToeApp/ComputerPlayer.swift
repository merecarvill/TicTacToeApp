
import Foundation

public class ComputerPlayer {

  public init() {

  }

  public func makeMove(gameState: Game) -> Int {
    let boardMarks = gameState.getBoardMarks()
    var availableSpaces: [Int] = []

    for spaceId in (0..<boardMarks.count) {
      if boardMarks[spaceId] == PlayerMark.NONE {
        availableSpaces.append(spaceId)
      }
    }

    makeRequest(gameState)

    return getRandomElement(availableSpaces)
  }

  private func getRandomElement(array: [Int]) -> Int {
    return array[Int(arc4random_uniform(UInt32(array.count)))]
  }

  private func makeRequest(game: Game) {

    func httpGet(request: NSURLRequest, callback: (String?, NSError?) -> Void) {
      let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
        guard error == nil && data != nil else {
          callback(nil, error)
          return
        }

        callback(String(data: data!, encoding: NSUTF8StringEncoding), nil)
      }
      task.resume()
    }

    let request = NSMutableURLRequest(URL: NSURL(string: "http://107.170.25.194:5000?board=" + boardToString(game.getBoardMarks()))!)

    httpGet(request) { string, error in
      guard error == nil && string != nil else {
        print(error?.localizedDescription)
        return
      }

      print(string!)
    }
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
