import Foundation
import SwiftHttp

/// The JSON decoder is already a valid HTTP data decoder
extension JSONDecoder: HttpDataDecoder {}

/// The property list decoder is already a valid HTTP data decoder
extension PropertyListDecoder: HttpDataDecoder {}
