import Foundation

protocol Requestable {
    associatedtype ResponseType
    var url: String { get }
    var defaultResponse: ResponseType { get }
}
