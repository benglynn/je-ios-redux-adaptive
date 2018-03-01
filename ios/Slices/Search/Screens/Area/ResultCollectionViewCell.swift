import UIKit

class ResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    
    func update(_ restaurant: Restaurant) {
        title.text = restaurant.title
    }

}
