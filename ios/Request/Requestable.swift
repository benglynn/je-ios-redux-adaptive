import Foundation

protocol Requestable {
    associatedtype ResponseType
    var url: String { get }
    var minLatency: Float { get }
    var defaultResponse: ResponseType { get }
}
