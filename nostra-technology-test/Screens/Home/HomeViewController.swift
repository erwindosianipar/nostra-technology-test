//
//  HomeViewController.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit
import RxSwift

internal final class HomeViewController: ViewController {
    
    // MARK: - UI Properties
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.getLayout(type: .heroCard)).then {
        $0.register(cell: HeroCardCollectionViewCell.self)
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - HomeViewController Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupLargeTitleAndSearchView() {
        self.title = "Dota 2"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupView() {
        setupLargeTitleAndSearchView()
        self.view.addSubviews(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cell: HeroCardCollectionViewCell.self)
        return cell
    }
}
