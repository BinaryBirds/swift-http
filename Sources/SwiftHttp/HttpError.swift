//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Foundation

public enum HttpError: LocalizedError {
    case invalidResponse
    case invalidStatusCode
    case statusCode(HttpResponse)
    case missingHeader(HttpResponse)
    case invalidHeaderValue(HttpResponse)
    case unknown(Error)
}
