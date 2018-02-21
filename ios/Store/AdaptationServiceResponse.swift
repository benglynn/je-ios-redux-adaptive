import Foundation

struct AdaptationServiceResponse: Codable {
    
    struct Action: Codable {
        let type: String
        let active: Bool
        let id: String
    }
    
    let actions: [AdaptationServiceResponse.Action]
}
