import UIKit

class AreaFlowLayout: UICollectionViewFlowLayout {
    
    static var cellWidth: CGFloat? = nil
    static var columns: Int? = nil
    var lastSafeWidth: CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let safeWidth: CGFloat = min(collectionView!.bounds.width, collectionView!.safeAreaLayoutGuide.layoutFrame.width)
        if safeWidth != lastSafeWidth {
            lastSafeWidth = safeWidth
            AreaFlowLayout.columns = Int(max(1, floor( (safeWidth - sectionInset.left + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing) )))
            let interCellSpace = CGFloat(AreaFlowLayout.columns! - 1) * minimumInteritemSpacing
            AreaFlowLayout.cellWidth = floor( (safeWidth - sectionInset.left - interCellSpace - sectionInset.right) / CGFloat(AreaFlowLayout.columns!) )
            invalidateLayout()
        }
        return super.layoutAttributesForElements(in: rect)
    }
}
