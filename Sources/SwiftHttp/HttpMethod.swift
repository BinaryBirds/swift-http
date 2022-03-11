//
//  HttpMethod.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

///
/// Common HTTP methods
///
/// For more details, please visit: [iana.org](https://www.iana.org/assignments/http-methods/http-methods.xhtml)
///
public enum HttpMethod: String {
    
    case acl
    case baselineControl = "baseline-control"
    case bind
    case checkin
    case checkout
    case connect
    case copy
    case delete
    case get
    case head
    case label
    case link
    case lock
    case merge
    case mkactivity
    case mkcalendar
    case mkcol
    case mkredirectref
    case mkworkspace
    case move
    case options
    case orderpatch
    case patch
    case post
    case pri
    case propfind
    case proppatch
    case put
    case rebind
    case report
    case search
    case trace
    case unbind
    case uncheckout
    case unlink
    case unlock
    case update
    case updateredirectref
    case versionControl = "version-control"
}
