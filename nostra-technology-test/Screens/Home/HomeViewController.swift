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
    
    private let informationLabel = UILabel()
    private lazy var pillCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout.getLayout(type: .pill)).then {
            $0.register(cell: FilterPillCollectionViewCell.self)
            $0.backgroundColor = .white
            $0.delegate = self
            $0.dataSource = self
        }
    
    private lazy var heroCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout.getLayout(type: .card)).then {
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
        self.view.addSubviews(pillCollectionView, informationLabel, heroCollectionView)
        pillCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        informationLabel.snp.makeConstraints {
            $0.top.equalTo(pillCollectionView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        heroCollectionView.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        fetchAPI()
    }
    
    private func fetchAPI() {
        self.viewModel?.heroStats()
            .asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] response in
                if response.isEmpty {
                    self?.showAlert(title: "Error", message: "Data Not Found", action: nil)
                    return
                }
                self?.viewModel?.heroes = response
                self?.informationLabel.text = "Showing \(response.count) heroes"
                self?.pillCollectionView.reloadData()
                self?.heroCollectionView.reloadData()
                self?.pillCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
            },
            onError: { [weak self] error in
                self?.checkInternetConnection(error: error, action: {
                    self?.fetchAPI()
                })
            })
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.viewModel {
            switch collectionView {
            case pillCollectionView:
                model.temp = indexPath.row == 0 ? model.heroes.sorted { $0.localized_name < $1.localized_name } : model.heroes.filter {
                    $0.roles.contains(model.roles[indexPath.row])
                }
                self.informationLabel.text = "Showing \(model.temp.count) heroes"
                self.heroCollectionView.reloadData()
                self.heroCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            case heroCollectionView:
                self.navigationEvent.send(.next(model.temp[indexPath.row]))
            default:
                return
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let model = self.viewModel {
            switch collectionView {
            case pillCollectionView:
                return model.roles.count
            case heroCollectionView:
                return model.temp.count
            default:
                return 0
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = self.viewModel {
            switch collectionView {
            case pillCollectionView:
                let cell = collectionView.dequeueReusableCell(for: indexPath, cell: FilterPillCollectionViewCell.self)
                cell.configure(data: model.roles[indexPath.row])
                return cell
            case heroCollectionView:
                let cell = collectionView.dequeueReusableCell(for: indexPath, cell: HeroCardCollectionViewCell.self)
                cell.configure(data: model.temp[indexPath.row])
                return cell
            default:
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
}
