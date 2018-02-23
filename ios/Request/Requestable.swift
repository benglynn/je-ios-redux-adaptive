import Foundation

protocol Requestable {
    associatedtype ResponseType
    var baseUrl: String { get }
    var queryItems: [URLQueryItem] { get }
    func prepare(_ urlComponents: inout URLComponents)
    func prepare(_ request: inout URLRequest)
}

extension Requestable {
    
    func prepare(_ urlComponents: inout URLComponents) {
        urlComponents.queryItems = queryItems
    }
    
    func prepare(_ request: inout URLRequest) {}
}

enum RequestableError: Error {
    case clientError
    case serverError
    case parseError
}
