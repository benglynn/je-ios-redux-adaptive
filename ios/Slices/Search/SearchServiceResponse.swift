import Foundation

struct SearchServiceResponse: Codable {
    
    struct Restaurant: Codable {
        let Name: String
    }
    
    struct MetaDataStruct: Codable {
        let ResultCount: Int
    }
    
    let OpenRestaurants: [Restaurant]
    let ClosedRestaurants: [Restaurant]
    let MetaData: SearchServiceResponse.MetaDataStruct
}
