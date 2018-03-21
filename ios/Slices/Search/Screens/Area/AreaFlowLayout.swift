import UIKit
import RxSwift

class AreaFlowLayout: UICollectionViewFlowLayout {
    
    var cellWidth: CGFloat? = nil
    var columns: Int? = nil
    var lastSafeWidth: CGFloat = 0
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let safeWidth: CGFloat = min(collectionView!.bounds.width, collectionView!.safeAreaLayoutGuide.layoutFrame.width)
        if safeWidth != lastSafeWidth {
            lastSafeWidth = safeWidth
            columns = Int(max(1, floor( (safeWidth - sectionInset.left + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing) )))
            let interCellSpace = CGFloat(columns! - 1) * minimumInteritemSpacing
            cellWidth = floor( (safeWidth - sectionInset.left - interCellSpace - sectionInset.right) / CGFloat(columns!) )
            invalidateLayout()
        }
        return super.layoutAttributesForElements(in: rect)
    }
}
