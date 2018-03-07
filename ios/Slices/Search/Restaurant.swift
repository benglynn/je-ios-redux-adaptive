import Foundation

struct Restaurant: Codable {
    
    let cuisines: String
    let deliveryCost: Decimal
    let deliveryStartTime: String?
    let drivingDistance: Double
    let isCollectNow: Bool
    let isDeliveryNow: Bool
    let isOpen: Bool
    let isSponsored: Bool
    let logUrl: String
    let openingTime: String
    let percentOff: Decimal
    let rating: Double
    let ratings: Int32
    let title: String
    
    init(_ serviceRestaurant: SearchServiceResponse.Restaurant, isOpen: Bool) {
        self.cuisines = serviceRestaurant.Cuisines.map { cuisine in cuisine.Name }.joined(separator: ", ")
        self.deliveryCost = serviceRestaurant.DeliveryCost
        self.deliveryStartTime = serviceRestaurant.DeliveryStartTime.toDate()?.toTimeString()
        self.drivingDistance = serviceRestaurant.DriveDistance
        self.isCollectNow = serviceRestaurant.IsCollection
        self.isDeliveryNow = serviceRestaurant.IsDelivery
        self.isOpen = isOpen
        self.isSponsored = serviceRestaurant.IsSponsored
        self.logUrl = serviceRestaurant.LogoUrl.replacingOccurrences(of: "http://", with: "https://")
        self.openingTime = serviceRestaurant.OpeningTime
        self.percentOff = serviceRestaurant.OfferPercent
        self.rating = serviceRestaurant.RatingDetails.StarRating
        self.ratings = serviceRestaurant.RatingDetails.Count
        self.title = serviceRestaurant.Name
    }
}
