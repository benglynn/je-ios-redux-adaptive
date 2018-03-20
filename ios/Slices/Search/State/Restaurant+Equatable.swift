import Foundation

extension Restaurant: Equatable {
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.cuisines == rhs.cuisines &&
            lhs.deliveryCost == rhs.deliveryCost &&
            lhs.drivingDistance == rhs.drivingDistance &&
            lhs.isCollectNow == rhs.isCollectNow &&
            lhs.isDeliveryNow == rhs.isDeliveryNow &&
            lhs.isOpen == rhs.isOpen &&
            lhs.isSponsored == rhs.isSponsored &&
            lhs.logUrl == rhs.logUrl &&
            lhs.openingTime == rhs.openingTime &&
            lhs.percentOff == rhs.percentOff &&
            lhs.rating == rhs.rating &&
            lhs.ratings == rhs.ratings &&
            lhs.title == rhs.title
    }
}
