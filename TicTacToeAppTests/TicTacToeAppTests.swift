import Quick
import Nimble

class FooSpec: QuickSpec {
  override func spec() {

    describe("something") {

      context("when something else") {

        it("is true") {
          expect(true)
        }
      }
    }
  }
}
