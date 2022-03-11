//
//  HttpDataDecoder.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpDataDecoder {
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: HttpDataDecoder {}
extension PropertyListDecoder: HttpDataDecoder {}
