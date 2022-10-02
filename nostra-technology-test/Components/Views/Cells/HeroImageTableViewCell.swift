//
//  HeroImageTableViewCell.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 02/10/22.
//

import UIKit

final class HeroImageTableViewCell: UITableViewCell {
    
    private let heroImageView = UIImageView().then {
        $0.contentMode = UIDevice.current.orientation == .portrait ? .scaleToFill : .scaleAspectFit
        $0.backgroundColor = .black
    }
    
    private func commonInit() {
        self.contentView.addSubview(heroImageView)
        heroImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(DeviceInformation.screenWidth / (UIDevice.current.orientation == .portrait ? 2 : 4))
        }
    }
    
    func configure(image: String, completion: (() -> Void)?) {
        commonInit()
        heroImageView.loadImage(url: image.wrapBaseURL(), completion: {
            completion?()
        })
    }
}
