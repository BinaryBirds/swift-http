
public struct HttpBody<T, S: AsyncSequence & Sendable> where S.Element == T {
    
    enum Value {
        case stream(S, Length)
        case bytes(T)
    }
    
    public enum Length {
        case known(UInt)
        case unknown
    }

    var value: Value

    init(_ value: Value) {
        self.value = value
    }

    public static func stream(
        _ sequence: S,
        length: Length
    ) -> Self {
        self.init(.stream(sequence, length))
    }
    
    public static func bytes(_ data: T) -> Self {
        self.init(.bytes(data))
    }
}
