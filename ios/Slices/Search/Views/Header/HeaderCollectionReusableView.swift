import UIKit

enum AreaSectionType {
    case open
    case closed
}

struct AreaHeaderState {
    let number: Int
    let type: AreaSectionType
    let postcode: String
}

class HeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var postcode: UILabel!
    
    func update(with state: AreaHeaderState) {
        title.text = {
            switch state.type {
            case .open: return "open in"
            case .closed: return "aren't taking orders"
            }
        }()
        number.text = "\(state.number)"
        postcode.text = state.postcode
        postcode.isHidden = state.type != .open
    }
}
