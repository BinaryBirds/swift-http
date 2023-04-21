import Foundation

extension Data {

    /// A variable that represents a `String` object representing the `Data` object in utf8 encoding.
    var logValue: String {
        "\n" + String(data: self, encoding: .utf8)!
    }
}
