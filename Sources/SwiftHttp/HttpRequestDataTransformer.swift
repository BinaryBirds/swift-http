//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpRequestDataTransformer {
    associatedtype T: Encodable
    
    var headers: [HttpHeaderKey: String] { get }

    func encode(_ content: T) throws -> Data
}

