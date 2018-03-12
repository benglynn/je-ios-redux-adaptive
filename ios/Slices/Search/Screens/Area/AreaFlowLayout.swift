import UIKit

class AreaFlowLayout: UICollectionViewFlowLayout {
    
    var cellWidthCache = [CGFloat: CGFloat]()
    
    func cellWidth(within safeWidth: CGFloat) -> CGFloat {
        let cached = cellWidthCache[safeWidth]
        guard cached != nil else {
            let numCellsInRow = max(1, floor( (safeWidth - sectionInset.left + minimumInteritemSpacing) / (itemSize.width + minimumInteritemSpacing) ))
            let interCellSpace = (numCellsInRow - 1) * minimumInteritemSpacing
            let cellWidth = floor( (safeWidth - sectionInset.left - interCellSpace - sectionInset.right) / numCellsInRow )
            cellWidthCache[safeWidth] = cellWidth
            return cellWidth
        }
        return cached!
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        guard collectionView != nil else { return attributes }
        let safeWidth = min(collectionView!.bounds.width, collectionView!.safeAreaLayoutGuide.layoutFrame.width)
        attributes?.bounds.size.width = cellWidth(within: safeWidth)
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAttributes = super.layoutAttributesForElements(in: rect)
        return allAttributes?.flatMap { attributes in
            switch attributes.representedElementCategory {
            case .cell: return layoutAttributesForItem(at: attributes.indexPath)
            default: return attributes
            }
        }
    }
}
