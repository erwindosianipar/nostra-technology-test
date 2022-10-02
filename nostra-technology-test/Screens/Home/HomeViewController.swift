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
    private let filterButton = UIButton(type: .custom).then {
        $0.addTarget(self, action: #selector(onTapFilterButton), for: .touchUpInside)
        $0.backgroundColor = .white
        $0.setImage(UserDefaultConfig.heroFilter == .default ? .filterCirlce : .filterCircleFill, for: .normal)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        $0.layer.cornerRadius = 20
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowRadius = 3.0
    }
    
    private lazy var filterViewController = FilterViewController(viewModel: FilterViewModel()).then {
        $0.delegate = self
    }
    
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
    private var loading = true
    private var activeFilterRole = ""
    
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
        self.view.addSubviews(
            pillCollectionView,
            informationLabel,
            heroCollectionView,
            filterButton
        )
        pillCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
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
        filterButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        fetchAPI()
    }
    
    private func fetchAPI() {
        self.loading = true
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
                self?.loading = false
                self?.pillCollectionView.reloadData()
                self?.heroCollectionView.reloadData()
                self?.pillCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
            },
            onError: { [weak self] error in
                self?.loading = false
                self?.checkInternetConnection(error: error, action: {
                    self?.fetchAPI()
                })
            })
            .disposed(by: disposeBag)
    }
    
    private func updateDataAfterFilterChanged() {
        guard let model = self.viewModel else {
            return
        }
        model.temp = self.activeFilterRole.isEmpty ? model.heroes : model.heroes.filter {
            $0.roles.contains(self.activeFilterRole)
        }
        self.heroCollectionView.reloadData()
    }
    
    @objc private func onTapFilterButton() {
        self.present(filterViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: FilterViewControllerDelegate {
    
    func onDismissViewController() {
        updateDataAfterFilterChanged()
        filterButton.setImage(.filterCircleFill, for: .normal)
        filterViewController.reloadData()
        filterViewController.dismiss(animated: true, completion: nil)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        filterButton.isHidden = scrollView == heroCollectionView ? true : false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        filterButton.isHidden = scrollView == heroCollectionView ? decelerate : false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        filterButton.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = self.viewModel {
            switch collectionView {
            case pillCollectionView:
                model.temp = []
                model.temp = indexPath.row == 0 ? model.heroes : model.heroes.filter {
                    self.activeFilterRole = model.roles[indexPath.row]
                    return $0.roles.contains(self.activeFilterRole)
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
        if loading {
            return 15
        }
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
        if loading {
            switch collectionView {
            case pillCollectionView:
                let cell = collectionView.dequeueReusableCell(for: indexPath, cell: FilterPillCollectionViewCell.self)
                return cell
            case heroCollectionView:
                let cell = collectionView.dequeueReusableCell(for: indexPath, cell: HeroCardCollectionViewCell.self)
                return cell
            default:
                return UICollectionViewCell()
            }
        }
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
