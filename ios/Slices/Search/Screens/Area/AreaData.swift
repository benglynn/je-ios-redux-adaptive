import UIKit
import RxDataSources

typealias AreaDataSource = RxCollectionViewSectionedReloadDataSource<AreaSection>

let configureCell: AreaDataSource.ConfigureCell = { (dataSource, collectionView, indexPath, restaurant) -> UICollectionViewCell in
    let layout = collectionView.collectionViewLayout as! AreaFlowLayout
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ResultCollectionViewCell
    cell.layout = layout
    cell.update(restaurant)
    return cell
}

let configureSupplementaryView: AreaDataSource.ConfigureSupplementaryView = { dataSource, collectionView, kind, indexPath in
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
    let section = dataSource[indexPath.section]
    (header as! HeaderCollectionReusableView).update(with: AreaHeaderState(
        number: section.items.count, type: section.sectionType, postcode: "BS3 4SH"))
    return header
}
