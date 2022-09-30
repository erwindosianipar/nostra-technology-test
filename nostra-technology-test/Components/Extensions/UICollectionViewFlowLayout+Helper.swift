//
//  UICollectionViewFlowLayout+Helper.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

enum UICollectionViewFlowLayoutRowType {
    case heroCard
}

extension CGSize {
    
    static var heroCardItemSize: CGSize {
        let itemWidth = DeviceInformation.screenWidth / 3 - 10
        return CGSize(width: itemWidth, height: DeviceInformation.screenWidth / 3 - 20)
    }
}

extension UIEdgeInsets {
    
    static var defaultEdgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension UICollectionViewFlowLayout {
    
    static func getLayout(type: UICollectionViewFlowLayoutRowType) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        switch type {
        case .heroCard:
            layout.itemSize = .heroCardItemSize
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = .zero
        }
        
        return layout
    }
}
