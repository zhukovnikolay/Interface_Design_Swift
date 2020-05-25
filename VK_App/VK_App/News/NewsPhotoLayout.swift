////
////  NewsPhotoLayout.swift
////  VK_App
////
////  Created by Nikolay Zhukov on 24.05.2020.
////  Copyright © 2020 Nikolay Zhukov. All rights reserved.
////
//
//
//import UIKit
//
//class CustomLayout: UICollectionViewLayout {
//    
//
//    var attr = [IndexPath: UICollectionViewLayoutAttributes]()
//    var columnCount = 2
//    var cellHeight: CGFloat = 100
//    var totalCellsHeight: CGFloat = 0
//
//
//
//    override func prepare() {
//        attr = [:]
//
//        guard let collectionView = self.collectionView else { return }
//
//        let itemCount = collectionView.numberOfItems(inSection: 0)
//
//        guard itemCount > 0 else { return }
//
//        let bigCellWigth = collectionView.frame.width
//        let smallCellWigth = collectionView.frame.width / CGFloat(columnCount)
//
//
//        var lastY: CGFloat = 0
//        var lastX: CGFloat = 0
//
//        for index in 0..<itemCount {
//            let indexPath = IndexPath(item: index, section: 0)
//            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//            let isBigCell = (index + 1) % (self.columnCount + 1) == 0
//
//            if isBigCell {
//                attributes.frame = CGRect(x: 0, y: lastY, width: bigCellWigth, height: self.cellHeight)
//                lastY += self.cellHeight
//            } else {
//                attributes.frame = CGRect(x: lastX, y: lastY, width: smallCellWigth, height: self.cellHeight)
//
//                let isLastCollumn = (index + 2) % (self.columnCount + 1) == 0 || index == itemCount - 1
//
//                if isLastCollumn {
//                    lastX = 0
//                    lastY += self.cellHeight
//                } else {
//                    lastX += smallCellWigth
//                }
//
//            }
//
//            attr[indexPath] = attributes
//            self.totalCellsHeight = lastY
//        }
//
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        return attr.values.filter { attributes in
//            return rect.intersects(attributes.frame)
//        }
//    }
//
//
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return attr[indexPath]
//    }
//
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellsHeight)
//    }
//
//
//}
