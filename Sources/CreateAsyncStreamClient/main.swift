import CreateAsyncStream

@CreateAsyncStream(of: Int, named: "number")
class Example {
  init() {}
  func something() {
    _numberContinuation.yield(6)
  }
}

//class Example2 {
//  init() {}
//
//  @CreateAsyncStream2
//  public var numbers: AsyncStream<Int>
//}
