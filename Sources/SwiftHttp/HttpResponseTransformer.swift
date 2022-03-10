//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

public protocol HttpResponseTransformer {
    
    associatedtype T: Decodable
    
    var validators: [HttpResponseValidator] { get }
    
    func decode(_ data: Data) throws -> T
}

