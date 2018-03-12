import UIKit

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cuisines: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var collectNow: UILabel!
    @IBOutlet weak var deliveryCost: UILabel!
    @IBOutlet weak var deliveryTime: UILabel!
    @IBOutlet weak var preOrder: UILabel!
    @IBOutlet weak var offerText: UILabel!
    @IBOutlet weak var sponsored: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var ratings: UILabel!
    @IBOutlet weak var stars: RatingsView!
    @IBOutlet weak var contents: UIView!
    
    func update(_ restaurant: Restaurant) {
        collectNow.isHidden = !(restaurant.isCollectNow && !restaurant.isDeliveryNow)
        deliveryCost.isHidden = !restaurant.isDeliveryNow
        deliveryTime.isHidden = !(!restaurant.isCollectNow && !restaurant.isDeliveryNow && restaurant.deliveryStartTime != nil)
        // offer.isHidden = !(restaurant.percentOff > 0)
        preOrder.isHidden = restaurant.isOpen
        sponsored.isHidden = !restaurant.isSponsored
        title.text = restaurant.title
        cuisines.text = restaurant.cuisines
        distance.text = "\(restaurant.drivingDistance) mi"
        deliveryTime.text = "Delivering from \(restaurant.deliveryStartTime ?? "")"
        deliveryCost.text = restaurant.deliveryCost == 0 ? "Delivery: Free" : "Delivery £\(restaurant.deliveryCost)"
        offerText.text = "\(restaurant.percentOff)% off"
        logo.downloaded(fromLocation: restaurant.logUrl)
        ratings.attributedText = newAttributedText(from: restaurant.ratings, matching: ratings)
        stars.render(rating: restaurant.rating)
        setNeedsLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectNow.isHidden = true
        deliveryCost.isHidden = true
        deliveryTime.isHidden = true
        // offer.isHidden = true
        preOrder.isHidden = true
        sponsored.isHidden = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    private func newAttributedText(from ratings: Int32, matching label: UILabel) -> NSAttributedString {
         let commaAttributes = label.attributedText?.attributes(at: 0, effectiveRange: nil)
        let numberAttributes = label.attributedText?.attributes(at: 1, effectiveRange: nil)
        let digitsCount = String(ratings).count
        let newRatings = NSMutableAttributedString(string: "(\(ratings))", attributes: numberAttributes)
        newRatings.setAttributes(commaAttributes, range: NSRange(location: 0, length: 1))
        newRatings.setAttributes(commaAttributes, range: NSRange(location: digitsCount+1, length: 1))
        return newRatings        
    }

}
