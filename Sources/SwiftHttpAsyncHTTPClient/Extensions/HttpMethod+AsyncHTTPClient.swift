import NIOHTTP1
import SwiftHttp

extension HttpMethod {

    var httpMethod: HTTPMethod {
        switch self {
        case .acl:
            return .ACL
        case .baselineControl:
            return .RAW(value: rawValue.uppercased())
        case .bind:
            return .BIND
        case .checkin:
            return .RAW(value: rawValue.uppercased())
        case .checkout:
            return .CHECKOUT
        case .connect:
            return .CONNECT
        case .copy:
            return .COPY
        case .delete:
            return .DELETE
        case .get:
            return .GET
        case .head:
            return .HEAD
        case .label:
            return .RAW(value: rawValue.uppercased())
        case .link:
            return .LINK
        case .lock:
            return .LOCK
        case .merge:
            return .MERGE
        case .mkactivity:
            return .MKACTIVITY
        case .mkcalendar:
            return .MKCALENDAR
        case .mkcol:
            return .MKCOL
        case .mkredirectref:
            return .RAW(value: rawValue.uppercased())
        case .mkworkspace:
            return .RAW(value: rawValue.uppercased())
        case .move:
            return .MOVE
        case .options:
            return .OPTIONS
        case .orderpatch:
            return .RAW(value: rawValue.uppercased())
        case .patch:
            return .PATCH
        case .post:
            return .POST
        case .pri:
            return .RAW(value: rawValue.uppercased())
        case .propfind:
            return .PROPFIND
        case .proppatch:
            return .PROPPATCH
        case .put:
            return .PUT
        case .rebind:
            return .REBIND
        case .report:
            return .REPORT
        case .search:
            return .SEARCH
        case .trace:
            return .TRACE
        case .unbind:
            return .UNBIND
        case .uncheckout:
            return .RAW(value: rawValue.uppercased())
        case .unlink:
            return .UNLINK
        case .unlock:
            return .UNLOCK
        case .update:
            return .RAW(value: rawValue.uppercased())
        case .updateredirectref:
            return .RAW(value: rawValue.uppercased())
        case .versionControl:
            return .RAW(value: rawValue.uppercased())
        }
    }
}
