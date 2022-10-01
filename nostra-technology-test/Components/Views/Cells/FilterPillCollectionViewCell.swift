//
//  FilterPillCollectionViewCell.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 01/10/22.
//

import UIKit

final class FilterPillCollectionViewCell: UICollectionViewCell, SkeletonView {
    
    private let button = UIButton().then {
        $0.backgroundColor = .black.withAlphaComponent(0.2)
        $0.layer.cornerRadius = 15
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var isSelected: Bool {
        didSet {
            button.backgroundColor = .black.withAlphaComponent(isSelected ? 0.8 : 0.2)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.setTitle(nil, for: .normal)
    }
    
    private func commonInit() {
        self.contentView.addSubviews(button)
        button.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(data: String) {
        self.button.setTitle(data, for: .normal)
        hideSkeleton()
    }
}
