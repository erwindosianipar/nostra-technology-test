//
//  HeroCardCollectionViewCell.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

final class HeroCardCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.text = "Lorem Ipsum Dolor"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubviews(imageView, titleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(DeviceInformation.screenWidth / 3 - 20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.height.equalTo(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
