//
//  HttpResponseValidator.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 09..
//

import Foundation

public protocol HttpResponseValidator {
    
    func validate(_ response: HttpResponse) throws
}

