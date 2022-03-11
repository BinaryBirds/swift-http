//
//  HttpHeaderKey.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Type safe header key wrapper
public enum HttpHeaderKey: Hashable {

    /// Type safe key using a `HttpHeader` value
    case key(HttpHeader)
    
    /// Custom header key as a `String` value
    case custom(String)
    
    /// Raw String value of the header key
    public var rawValue: String {
        switch self {
        case .key(let header):
            return header.rawValue
        case .custom(let value):
            return value
        }
    }
}
