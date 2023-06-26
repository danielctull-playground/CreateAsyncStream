import CreateAsyncStream

@CreateAsyncStream(of: Int, named: "number")
class Example {
  init() {}
  func something() {
    _numberContinuation.yield(6)
  }
}

//class Example2 {
//    init() {}
//
//    @CreateAsyncStream2
//    public var numbers: AsyncStream<Int>
//}

// The above code should be expanding to the code below (excepting the class
// name change. The proof is in the working macro test!
//
// There is a compilation issue saying "Return from initializer without
// initializing all stored properties". This doesn't occur in the source below,
// which replicates what should be generated with the macro.

class Example3 {
    init() {}

    public var numbers: AsyncStream<Int> {
        get {
            _numbers
        }
    }

    private let (_numbers, _numbersContinuation) = AsyncStream.makeStream(of: Int.self)
}
