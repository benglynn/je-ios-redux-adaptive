import Foundation

struct AdaptationService {
    static let url = "https://us-central1-state-service.cloudfunctions.net/actions"
}

struct AdaptationServiceAction: Codable {
    let type: String
    let active: Bool
    let id: String
}

struct AdaptationServiceResponse: Codable {
    let actions: [AdaptationServiceAction]
}
