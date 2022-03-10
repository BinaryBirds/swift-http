//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpResponseDataDecoder {
    
    associatedtype T: Decodable
    
    func decode(_ data: Data) throws -> T
}

