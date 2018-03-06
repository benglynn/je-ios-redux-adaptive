import UIKit

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cuisines: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var collectNow: UILabel!
    @IBOutlet weak var deliveryCost: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var preOrder: UILabel!
    @IBOutlet weak var offer: UIStackView!
    @IBOutlet weak var offerText: UILabel!
    
    func update(_ restaurant: Restaurant) {
        title.text = restaurant.title
        cuisines.text = restaurant.cuisines
        distance.text = "\(restaurant.drivingDistance) mi"
        collectNow.isHidden = !(restaurant.isCollectNow && !restaurant.isDeliveryNow)
        deliveryCost.isHidden = !restaurant.isDeliveryNow
        deliveryTime.isHidden = !(!restaurant.isCollectNow && !restaurant.isDeliveryNow && restaurant.deliveryStartTime != nil)
        preOrder.isHidden = restaurant.isOpen
        deliveryTime.text = "Delivering from \(restaurant.deliveryStartTime ?? "")"
        deliveryCost.text = "Delivery £\(restaurant.deliveryCost)"
        offer.isHidden = restaurant.percentOff == 0
        offerText.text = "\(restaurant.percentOff)% off"
        
    }

}
