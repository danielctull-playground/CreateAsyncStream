import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import CreateAsyncStreamMacros

let testMacros: [String: Macro.Type] = [
    "createAsyncStream": CreateAsyncStreamMacro.self,
    "CreateAsyncStream2": CreateAsyncStream2Macro.self,
]

final class CreateAsyncStreamTests: XCTestCase {
    func testMacro() {
        assertMacroExpansion(
            """
            @CreateAsyncStream(of: Int, named: "numbers")
            """,
            expandedSource: """
            public var numbers: AsyncStream<Int> { _numbers }
            private let (_numbers, _numbersContinuation)
               = AsyncStream.makeStream(of: Int.self)
            """,
            macros: testMacros
        )
    }

  func testMacro2() {
    assertMacroExpansion(
      """
      @CreateAsyncStream2
      public var numbers: AsyncStream<Int>
      """,
      expandedSource: """
      public var numbers: AsyncStream<Int> {
          get {
              _numbers.stream
          }
      }
      private let _numbers = AsyncStream.makeStream(of: Int.self)
      """,
      macros: testMacros
    )
  }
}
