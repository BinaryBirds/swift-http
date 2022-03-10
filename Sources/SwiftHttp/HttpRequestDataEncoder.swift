//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpRequestDataEncoder {
    
    associatedtype T: Encodable
    
    func encode(_ content: T) throws -> Data
}

