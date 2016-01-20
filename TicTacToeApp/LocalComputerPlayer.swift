import Foundation

public class LocalComputerPlayer {

    public init() {}

    public func makeMove(gameState: Game) -> Int {
        return getRandomElement(availableSpaces(gameState))
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
}
