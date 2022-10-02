//
//  HeroCardCollectionViewCell.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

final class HeroCardCollectionViewCell: UICollectionViewCell, SkeletonView {
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.2)
    }
    
    private let titleLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.titleLabel.text = nil
    }
    
    private func commonInit() {
        self.contentView.addSubviews(imageView, titleLabel)
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
        
        showSkeleton()
    }
    
    func configure(data: HeroStatsResponseModel) {
        self.imageView.loadImage(url: data.img.wrapBaseURL())
        self.titleLabel.text = data.localized_name
        hideSkeleton()
    }
}
