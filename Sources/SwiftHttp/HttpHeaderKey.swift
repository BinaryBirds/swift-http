//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public enum HttpHeaderKey: Hashable {

    case custom(String)
    case key(HttpHeader)
    
    public var keyValue: String {
        switch self {
        case .custom(let value):
            return value
        case .key(let header):
            return header.rawValue
        }
    }
    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(keyValue)
//    }
}
