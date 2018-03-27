import UIKit

@IBDesignable class RestaurantView: UIView, NibOwning {
    
    let openBackgroundColour = UIColor.white
    let closedBackgroundColour = UIColor.init(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
    let closedBorderColour = UIColor.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1)
    
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var ratingsView: RatingsView!
    @IBOutlet weak var ratingsCount: UILabel!
    @IBOutlet weak var cuisines: UILabel!
    @IBOutlet weak var new: UILabel!
    @IBOutlet weak var sponsored: UILabel!
    @IBOutlet weak var deal: UIView!
    @IBOutlet weak var dealLabel: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var preOrder: UILabel!
    
    func render(restaurant: Restaurant) {
        title.text = restaurant.title
        logo.download(fromLocation: restaurant.logUrl)
        ratingsView.render(rating: restaurant.rating)
        ratingsCount.text = String(restaurant.ratings)
        cuisines.text = restaurant.cuisines
        new.isHidden = !restaurant.isNew
        sponsored.isHidden = !restaurant.isSponsored
        deal.isHidden = !(restaurant.percentOff > 0)
        dealLabel.text = "\(restaurant.percentOff)% off"
        distance.text = "\(restaurant.drivingDistance) mi"
        if restaurant.isOpen {
            baseView.backgroundColor = openBackgroundColour
            layer.borderWidth = 0
            preOrder.isHidden = true
        } else {
            baseView.backgroundColor = closedBackgroundColour
            layer.borderWidth = 1
            layer.borderColor = closedBorderColour.cgColor
            preOrder.isHidden = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8.0
        clipsToBounds = true
    }
    
    // MARK: NibOwning
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }
    
}

