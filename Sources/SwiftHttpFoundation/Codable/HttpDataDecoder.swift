import Foundation
import SwiftHttp

/// The JSON encoder is already a valid HTTP data encoder
extension JSONEncoder: HttpDataEncoder {}

/// The property list encoder is already a valid HTTP data encoder
extension PropertyListEncoder: HttpDataEncoder {}
