//
//  HttpDataEncoder.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpDataEncoder {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

extension JSONEncoder: HttpDataEncoder {}
extension PropertyListEncoder: HttpDataEncoder {}
