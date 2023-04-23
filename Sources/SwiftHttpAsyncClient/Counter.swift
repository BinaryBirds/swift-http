import NIOCore

struct Counter: AsyncSequence, Sendable {
    typealias Element = ByteBuffer

    let limit: Int

    struct AsyncIterator : AsyncIteratorProtocol {
        let limit: Int
        var current = 1

        mutating func next() async -> ByteBuffer? {
            guard !Task.isCancelled else {
                return nil
            }

            guard current <= limit else {
                return nil
            }

            let result = current
            current += 1
            return .init(string: String(current))
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        return AsyncIterator(limit: limit)
    }
}
