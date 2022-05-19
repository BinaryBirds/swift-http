//
//  HttpHeaderKey.swift
//  SwiftHttp
//
//  Created by Tibor Bodecs on 2022. 03. 10..
//

import Foundation

/// Type safe header key wrapper
public struct HttpHeaderKey {
	
	public var rawValue: String
	
	public init(_ rawValue: String) { self.rawValue = rawValue }
	
	public static func custom(_ key: String) -> HttpHeaderKey { HttpHeaderKey(key) }
	
	@available(*, deprecated, message: "Use key directly")
	public static func key(_ key: HttpHeaderKey) -> HttpHeaderKey { key }
	
	/// Authorization header
	public static let authorization: HttpHeaderKey = "Authorization"
	
	/// Accept header
	public static let accept: HttpHeaderKey = "Accept"
	
	/// Permanent Message Header Field Names
	public static let acceptLanguage: HttpHeaderKey = "Accept-Language"
	public static let alsoControl: HttpHeaderKey = "Also-Control"
	public static let alternateRecipient: HttpHeaderKey = "Alternate-Recipient"
	public static let approved: HttpHeaderKey = "Approved"
	public static let aRCAuthenticationResults: HttpHeaderKey = "ARC-Authentication-Results"
	public static let aRCMessageSignature: HttpHeaderKey = "ARC-Message-Signature"
	public static let aRCSeal: HttpHeaderKey = "ARC-Seal"
	public static let archive: HttpHeaderKey = "Archive"
	public static let archivedAt: HttpHeaderKey = "Archived-At"
	public static let articleNames: HttpHeaderKey = "Article-Names"
	public static let articleUpdates: HttpHeaderKey = "Article-Updates"
	public static let authenticationResults: HttpHeaderKey = "Authentication-Results"
	public static let autoSubmitted: HttpHeaderKey = "Auto-Submitted"
	public static let autoforwarded: HttpHeaderKey = "Autoforwarded"
	public static let autosubmitted: HttpHeaderKey = "Autosubmitted"
	public static let base: HttpHeaderKey = "Base"
	public static let bcc: HttpHeaderKey = "Bcc"
	public static let body: HttpHeaderKey = "Body"
	public static let cancelKey: HttpHeaderKey = "Cancel-Key"
	public static let cancelLock: HttpHeaderKey = "Cancel-Lock"
	public static let cc: HttpHeaderKey = "Cc"
	public static let comments: HttpHeaderKey = "Comments"
	public static let contentAlternative: HttpHeaderKey = "Content-Alternative"
	public static let contentBase: HttpHeaderKey = "Content-Base"
	public static let contentDescription: HttpHeaderKey = "Content-Description"
	public static let contentDisposition: HttpHeaderKey = "Content-Disposition"
	public static let contentDuration: HttpHeaderKey = "Content-Duration"
	public static let contentfeatures: HttpHeaderKey = "Content-features"
	public static let contentID: HttpHeaderKey = "Content-ID"
	public static let contentIdentifier: HttpHeaderKey = "Content-Identifier"
	public static let contentLanguage: HttpHeaderKey = "Content-Language"
	public static let contentLocation: HttpHeaderKey = "Content-Location"
	public static let contentMD5: HttpHeaderKey = "Content-MD5"
	public static let contentReturn: HttpHeaderKey = "Content-Return"
	public static let contentTransferEncoding: HttpHeaderKey = "Content-Transfer-Encoding"
	public static let contentTranslationType: HttpHeaderKey = "Content-Translation-Type"
	public static let contentType: HttpHeaderKey = "Content-Type"
	public static let control: HttpHeaderKey = "Control"
	public static let conversion: HttpHeaderKey = "Conversion"
	public static let conversionWithLoss: HttpHeaderKey = "Conversion-With-Loss"
	public static let dLExpansionHistory: HttpHeaderKey = "DL-Expansion-History"
	public static let date: HttpHeaderKey = "Date"
	public static let dateReceived: HttpHeaderKey = "Date-Received"
	public static let deferredDelivery: HttpHeaderKey = "Deferred-Delivery"
	public static let deliveryDate: HttpHeaderKey = "Delivery-Date"
	public static let discardedX400IPMSExtensions: HttpHeaderKey = "Discarded-X400-IPMS-Extensions"
	public static let discardedX400MTSExtensions: HttpHeaderKey = "Discarded-X400-MTS-Extensions"
	public static let discloseRecipients: HttpHeaderKey = "Disclose-Recipients"
	public static let dispositionNotificationOptions: HttpHeaderKey = "Disposition-Notification-Options"
	public static let dispositionNotificationTo: HttpHeaderKey = "Disposition-Notification-To"
	public static let distribution: HttpHeaderKey = "Distribution"
	public static let dKIMSignature: HttpHeaderKey = "DKIM-Signature"
	public static let downgradedBcc: HttpHeaderKey = "Downgraded-Bcc"
	public static let downgradedCc: HttpHeaderKey = "Downgraded-Cc"
	public static let downgradedDispositionNotificationTo: HttpHeaderKey = "Downgraded-Disposition-Notification-To"
	public static let downgradedFinalRecipient: HttpHeaderKey = "Downgraded-Final-Recipient"
	public static let downgradedFrom: HttpHeaderKey = "Downgraded-From"
	public static let downgradedInReplyTo: HttpHeaderKey = "Downgraded-In-Reply-To"
	public static let downgradedMailFrom: HttpHeaderKey = "Downgraded-Mail-From"
	public static let downgradedMessageId: HttpHeaderKey = "Downgraded-Message-Id"
	public static let downgradedOriginalRecipient: HttpHeaderKey = "Downgraded-Original-Recipient"
	public static let downgradedRcptTo: HttpHeaderKey = "Downgraded-Rcpt-To"
	public static let downgradedReferences: HttpHeaderKey = "Downgraded-References"
	public static let downgradedReplyTo: HttpHeaderKey = "Downgraded-Reply-To"
	public static let downgradedResentBcc: HttpHeaderKey = "Downgraded-Resent-Bcc"
	public static let downgradedResentCc: HttpHeaderKey = "Downgraded-Resent-Cc"
	public static let downgradedResentFrom: HttpHeaderKey = "Downgraded-Resent-From"
	public static let downgradedResentReplyTo: HttpHeaderKey = "Downgraded-Resent-Reply-To"
	public static let downgradedResentSender: HttpHeaderKey = "Downgraded-Resent-Sender"
	public static let downgradedResentTo: HttpHeaderKey = "Downgraded-Resent-To"
	public static let downgradedReturnPath: HttpHeaderKey = "Downgraded-Return-Path"
	public static let downgradedSender: HttpHeaderKey = "Downgraded-Sender"
	public static let downgradedTo: HttpHeaderKey = "Downgraded-To"
	public static let encoding: HttpHeaderKey = "Encoding"
	public static let encrypted: HttpHeaderKey = "Encrypted"
	public static let expires: HttpHeaderKey = "Expires"
	public static let expiryDate: HttpHeaderKey = "Expiry-Date"
	public static let followupTo: HttpHeaderKey = "Followup-To"
	public static let from: HttpHeaderKey = "From"
	public static let generateDeliveryReport: HttpHeaderKey = "Generate-Delivery-Report"
	public static let importance: HttpHeaderKey = "Importance"
	public static let inReplyTo: HttpHeaderKey = "In-Reply-To"
	public static let incompleteCopy: HttpHeaderKey = "Incomplete-Copy"
	public static let injectionDate: HttpHeaderKey = "Injection-Date"
	public static let injectionInfo: HttpHeaderKey = "Injection-Info"
	public static let keywords: HttpHeaderKey = "Keywords"
	public static let language: HttpHeaderKey = "Language"
	public static let latestDeliveryTime: HttpHeaderKey = "Latest-Delivery-Time"
	public static let lines: HttpHeaderKey = "Lines"
	public static let listArchive: HttpHeaderKey = "List-Archive"
	public static let listHelp: HttpHeaderKey = "List-Help"
	public static let listID: HttpHeaderKey = "List-ID"
	public static let listOwner: HttpHeaderKey = "List-Owner"
	public static let listPost: HttpHeaderKey = "List-Post"
	public static let listSubscribe: HttpHeaderKey = "List-Subscribe"
	public static let listUnsubscribe: HttpHeaderKey = "List-Unsubscribe"
	public static let listUnsubscribePost: HttpHeaderKey = "List-Unsubscribe-Post"
	public static let messageContext: HttpHeaderKey = "Message-Context"
	public static let messageID: HttpHeaderKey = "Message-ID"
	public static let messageType: HttpHeaderKey = "Message-Type"
	public static let mIMEVersion: HttpHeaderKey = "MIME-Version"
	public static let mMHSExemptedAddress: HttpHeaderKey = "MMHS-Exempted-Address"
	public static let mMHSExtendedAuthorisationInfo: HttpHeaderKey = "MMHS-Extended-Authorisation-Info"
	public static let mMHSSubjectIndicatorCodes: HttpHeaderKey = "MMHS-Subject-Indicator-Codes"
	public static let mMHSHandlingInstructions: HttpHeaderKey = "MMHS-Handling-Instructions"
	public static let mMHSMessageInstructions: HttpHeaderKey = "MMHS-Message-Instructions"
	public static let mMHSCodressMessageIndicator: HttpHeaderKey = "MMHS-Codress-Message-Indicator"
	public static let mMHSOriginatorReference: HttpHeaderKey = "MMHS-Originator-Reference"
	public static let mMHSPrimaryPrecedence: HttpHeaderKey = "MMHS-Primary-Precedence"
	public static let mMHSCopyPrecedence: HttpHeaderKey = "MMHS-Copy-Precedence"
	public static let mMHSMessageType: HttpHeaderKey = "MMHS-Message-Type"
	public static let mMHSOtherRecipientsIndicatorTo: HttpHeaderKey = "MMHS-Other-Recipients-Indicator-To"
	public static let mMHSOtherRecipientsIndicatorCC: HttpHeaderKey = "MMHS-Other-Recipients-Indicator-CC"
	public static let mMHSAcp127MessageIdentifier: HttpHeaderKey = "MMHS-Acp127-Message-Identifier"
	public static let mMHSOriginatorPLAD: HttpHeaderKey = "MMHS-Originator-PLAD"
	public static let mTPriority: HttpHeaderKey = "MT-Priority"
	public static let newsgroups: HttpHeaderKey = "Newsgroups"
	public static let nNTPPostingDate: HttpHeaderKey = "NNTP-Posting-Date"
	public static let nNTPPostingHost: HttpHeaderKey = "NNTP-Posting-Host"
	public static let obsoletes: HttpHeaderKey = "Obsoletes"
	public static let organization: HttpHeaderKey = "Organization"
	public static let originalEncodedInformationTypes: HttpHeaderKey = "Original-Encoded-Information-Types"
	public static let originalFrom: HttpHeaderKey = "Original-From"
	public static let originalMessageID: HttpHeaderKey = "Original-Message-ID"
	public static let originalRecipient: HttpHeaderKey = "Original-Recipient"
	public static let originalSender: HttpHeaderKey = "Original-Sender"
	public static let originatorReturnAddress: HttpHeaderKey = "Originator-Return-Address"
	public static let originalSubject: HttpHeaderKey = "Original-Subject"
	public static let path: HttpHeaderKey = "Path"
	public static let pICSLabel: HttpHeaderKey = "PICS-Label"
	public static let postingVersion: HttpHeaderKey = "Posting-Version"
	public static let preventNonDeliveryReport: HttpHeaderKey = "Prevent-NonDelivery-Report"
	public static let priority: HttpHeaderKey = "Priority"
	public static let received: HttpHeaderKey = "Received"
	public static let receivedSPF: HttpHeaderKey = "Received-SPF"
	public static let references: HttpHeaderKey = "References"
	public static let relayVersion: HttpHeaderKey = "Relay-Version"
	public static let replyBy: HttpHeaderKey = "Reply-By"
	public static let replyTo: HttpHeaderKey = "Reply-To"
	public static let requireRecipientValidSince: HttpHeaderKey = "Require-Recipient-Valid-Since"
	public static let resentBcc: HttpHeaderKey = "Resent-Bcc"
	public static let resentCc: HttpHeaderKey = "Resent-Cc"
	public static let resentDate: HttpHeaderKey = "Resent-Date"
	public static let resentFrom: HttpHeaderKey = "Resent-From"
	public static let resentMessageID: HttpHeaderKey = "Resent-Message-ID"
	public static let resentReplyTo: HttpHeaderKey = "Resent-Reply-To"
	public static let resentSender: HttpHeaderKey = "Resent-Sender"
	public static let resentTo: HttpHeaderKey = "Resent-To"
	public static let returnPath: HttpHeaderKey = "Return-Path"
	public static let seeAlso: HttpHeaderKey = "See-Also"
	public static let sender: HttpHeaderKey = "Sender"
	public static let sensitivity: HttpHeaderKey = "Sensitivity"
	public static let solicitation: HttpHeaderKey = "Solicitation"
	public static let subject: HttpHeaderKey = "Subject"
	public static let summary: HttpHeaderKey = "Summary"
	public static let supersedes: HttpHeaderKey = "Supersedes"
	public static let tLSReportDomain: HttpHeaderKey = "TLS-Report-Domain"
	public static let tLSReportSubmitter: HttpHeaderKey = "TLS-Report-Submitter"
	public static let tLSRequired: HttpHeaderKey = "TLS-Required"
	public static let to: HttpHeaderKey = "To"
	public static let userAgent: HttpHeaderKey = "User-Agent"
	public static let vBRInfo: HttpHeaderKey = "VBR-Info"
	public static let x400ContentIdentifier: HttpHeaderKey = "X400-Content-Identifier"
	public static let x400ContentReturn: HttpHeaderKey = "X400-Content-Return"
	public static let x400ContentType: HttpHeaderKey = "X400-Content-Type"
	public static let x400MTSIdentifier: HttpHeaderKey = "X400-MTS-Identifier"
	public static let x400Originator: HttpHeaderKey = "X400-Originator"
	public static let x400Received: HttpHeaderKey = "X400-Received"
	public static let x400Recipients: HttpHeaderKey = "X400-Recipients"
	public static let x400Trace: HttpHeaderKey = "X400-Trace"
	public static let xrefcase: HttpHeaderKey = "Xrefcase"
	/// Provisional Message Header Field Names
	public static let apparentlyTo: HttpHeaderKey = "Apparently-To"
	public static let author: HttpHeaderKey = "Author"
	public static let eDIINTFeatures: HttpHeaderKey = "EDIINT-Features"
	public static let eesstVersion: HttpHeaderKey = "Eesst-Version"
	public static let errorsTo: HttpHeaderKey = "Errors-To"
	public static let formSub: HttpHeaderKey = "Form-Sub"
	public static let jabberID: HttpHeaderKey = "Jabber-ID"
	public static let mMHSAuthorizingUsers: HttpHeaderKey = "MMHS-Authorizing-Users"
	public static let privicon: HttpHeaderKey = "Privicon"
	public static let sIOLabel: HttpHeaderKey = "SIO-Label"
	public static let sIOLabelHistory: HttpHeaderKey = "SIO-Label-History"
	public static let xArchivedAt: HttpHeaderKey = "X-Archived-At"
	public static let xMittente: HttpHeaderKey = "X-Mittente"
	public static let xPGPSig: HttpHeaderKey = "X-PGP-Sig"
	public static let xRicevuta: HttpHeaderKey = "X-Ricevuta"
	public static let xRiferimentoMessageID: HttpHeaderKey = "X-Riferimento-Message-ID"
	public static let xTipoRicevuta: HttpHeaderKey = "X-TipoRicevuta"
	public static let xTrasporto: HttpHeaderKey = "X-Trasporto"
	public static let xVerificaSicurezza: HttpHeaderKey = "X-VerificaSicurezza"
}

extension HttpHeaderKey: Hashable, Codable, ExpressibleByStringLiteral, StringProtocol, RawRepresentable, CustomStringConvertible {
	public typealias UTF8View = String.UTF8View
	public typealias UTF16View = String.UTF16View
	public typealias UnicodeScalarView = String.UnicodeScalarView
	
	public var description: String { rawValue }
	public var startIndex: String.Index { rawValue.startIndex }
	public var endIndex: String.Index { rawValue.endIndex }
	public var utf8: String.UTF8View { rawValue.utf8 }
	public var utf16: String.UTF16View { rawValue.utf16 }
	public var unicodeScalars: String.UnicodeScalarView { rawValue.unicodeScalars }
    
    /// Creates a new instance with the specified raw value.
    /// - Parameter rawValue: The raw value to use for the new instance.
	public init?(rawValue: String) { self.init(rawValue) }
    
    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
	public init(stringLiteral value: String) { self.init(value) }
    
    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
	public init(from decoder: Decoder) throws {
		try self.init(String(from: decoder))
	}
    
    /// Creates a string from the given Unicode code units in the specified
    /// encoding.
    ///
    /// - Parameters:
    ///   - codeUnits: A collection of code units encoded in the encoding
    ///     specified in `sourceEncoding`.
    ///   - sourceEncoding: The encoding in which `codeUnits` should be
    ///     interpreted.

	public init<C, Encoding>(decoding codeUnits: C, as sourceEncoding: Encoding.Type) where C : Collection, Encoding : _UnicodeEncoding, C.Element == Encoding.CodeUnit {
		self.init(String(decoding: codeUnits, as: sourceEncoding))
	}
    
    /// Creates a string from the null-terminated, UTF-8 encoded sequence of
    /// bytes at the given pointer.
    ///
    /// - Parameter nullTerminatedUTF8: A pointer to a sequence of contiguous,
    ///   UTF-8 encoded bytes ending just before the first zero byte.
	public init(cString nullTerminatedUTF8: UnsafePointer<CChar>) {
		self.init(String(cString: nullTerminatedUTF8))
	}
	
    /// Creates a string from the null-terminated sequence of bytes at the given
    /// pointer.
    ///
    /// - Parameters:
    ///   - nullTerminatedCodeUnits: A pointer to a sequence of contiguous code
    ///     units in the encoding specified in `sourceEncoding`, ending just
    ///     before the first zero code unit.
    ///   - sourceEncoding: The encoding in which the code units should be
    ///     interpreted.
	public init<Encoding>(decodingCString nullTerminatedCodeUnits: UnsafePointer<Encoding.CodeUnit>, as sourceEncoding: Encoding.Type) where Encoding : _UnicodeEncoding {
		self.init(String(decodingCString: nullTerminatedCodeUnits, as: sourceEncoding))
	}
    
    /// Hashes the essential components of this value by feeding them into the
    /// given hasher.
    ///
    /// Implement this method to conform to the `Hashable` protocol. The
    /// components used for hashing must be the same as the components compared
    /// in your type's `==` operator implementation. Call `hasher.combine(_:)`
    /// with each of these components.
    ///
    /// - Important: Never call `finalize()` on `hasher`. Doing so may become a
    ///   compile-time error in the future.
    ///
    /// - Parameter hasher: The hasher to use when combining the components
    ///   of this instance.
	public func hash(into hasher: inout Hasher) {
		rawValue.hash(into: &hasher)
	}
    
    /// Encodes this value into the given encoder.
    ///
    /// If the value fails to encode anything, `encoder` will encode an empty
    /// keyed container in its place.
    ///
    /// This function throws an error if any values are invalid for the given
    /// encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
	public func encode(to encoder: Encoder) throws {
		try rawValue.encode(to: encoder)
	}
	
	public subscript(position: String.Index) -> Character {
		rawValue[position]
	}
	
	public subscript(bounds: Range<String.Index>) -> Substring {
		rawValue[bounds]
	}
	
	public mutating func write(_ string: String) {
		rawValue.write(string)
	}
	
	public func lowercased() -> String {
		rawValue.lowercased()
	}
	
	public func uppercased() -> String {
		rawValue.uppercased()
	}
	
	public func write<Target>(to target: inout Target) where Target : TextOutputStream {
		rawValue.write(to: &target)
	}
	
	public func withCString<Result>(_ body: (UnsafePointer<CChar>) throws -> Result) rethrows -> Result {
		try rawValue.withCString(body)
	}
	
	public func withCString<Result, Encoding>(encodedAs targetEncoding: Encoding.Type, _ body: (UnsafePointer<Encoding.CodeUnit>) throws -> Result) rethrows -> Result where Encoding : _UnicodeEncoding {
		try rawValue.withCString(encodedAs: targetEncoding, body)
	}
	
	public func index(after i: String.Index) -> String.Index {
		rawValue.index(after: i)
	}
	
	public func index(before i: String.Index) -> String.Index {
		rawValue.index(before: i)
	}
}
