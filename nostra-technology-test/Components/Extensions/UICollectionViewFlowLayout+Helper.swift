//
//  UICollectionViewFlowLayout+Helper.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

enum UICollectionViewFlowLayoutRowType {
    case pill
    case card
}

extension CGSize {
    
    static var heroCardItemSize: CGSize {
        let itemWidth = DeviceInformation.screenWidth / 3 - 10
        return CGSize(width: itemWidth, height: DeviceInformation.screenWidth / (UIDevice.current.orientation == .portrait ? 3 : 4) - 20)
    }
}

extension UIEdgeInsets {
    
    static var defaultEdgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    static var pillEdgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

extension UICollectionViewFlowLayout {
    
    static func getLayout(type: UICollectionViewFlowLayoutRowType) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        switch type {
        case .pill:
            layout.itemSize = CGSize(width: 100, height: 30)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = .pillEdgeInset
        case .card:
            layout.itemSize = .heroCardItemSize
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = .zero
        }
        return layout
    }
}
