import Foundation

struct SearchServiceResponse: Codable {
    
    struct Cuisine: Codable {
        let Name: String
        let SeoName: String
    }
    
    struct RatingDetailsStruct: Codable {
        let Count: Int32
        let StarRating: Double
    }
    
    struct Restaurant: Codable {
        let Name: String
        let Cuisines: [Cuisine]
        let DeliveryCost: Decimal
        let DeliveryStartTime: String
        let DriveDistance: Double
        let IsCollection: Bool
        let IsDelivery: Bool
        let IsSponsored: Bool
        let LogoUrl: String
        let OfferPercent: Decimal
        let OpeningTime: String
        let RatingDetails: RatingDetailsStruct
        
    }
    
    struct MetaDataStruct: Codable {
        let ResultCount: Int
    }
    
    let OpenRestaurants: [Restaurant]
    let ClosedRestaurants: [Restaurant]
    let MetaData: MetaDataStruct
}
