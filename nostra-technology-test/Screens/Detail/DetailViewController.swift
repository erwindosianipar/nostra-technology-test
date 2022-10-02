//
//  DetailViewController.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit
import RxSwift

internal final class DetailViewController: ViewController {
    
    // MARK: - UI Properties
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(cell: HeroImageTableViewCell.self)
        $0.register(cell: UITableViewCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - HomeViewController Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: DetailViewModel?
    
    init(viewModel: DetailViewModel) {
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
    
    private func setupView() {
        self.title = self.viewModel?.screenResult.localized_name
        self.view.addSubviews(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension DetailViewController: UITableViewDelegate {
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.viewModel?.screenResult {
            if section == 3 {
                return 4
            }
            if section == 5 {
                return model.roles.count
            }
            return 1
        }
        return 0
    }
    
    // swiftlint:disable cyclomatic_complexity
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel?.screenResult else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cell: HeroImageTableViewCell.self)
            cell.configure(image: model.img, completion: {
                cell.setNeedsLayout()
            })
            return cell
        } else if indexPath.section == 1 {
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: UITableViewCell.identifier)
            cell.imageView?.loadImage(url: model.img.wrapBaseURL(), completion: {
                cell.setNeedsLayout()
            })
            cell.textLabel?.text = model.localized_name
            cell.detailTextLabel?.text = model.primary_attr.uppercased()
            return cell
        } else if indexPath.section == 2 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
            cell.textLabel?.text = "Attack Type"
            cell.detailTextLabel?.text = model.attack_type
            return cell
        } else if indexPath.section == 3 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
            if indexPath.row == 0 {
                cell.textLabel?.text = "Base Health"
                cell.detailTextLabel?.text = String(Int(model.base_health))
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Base Mana"
                cell.detailTextLabel?.text = String(Int(model.base_mana))
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Base Armor"
                cell.detailTextLabel?.text = String(model.base_armor)
            } else if indexPath.row == 3 {
                cell.textLabel?.text = "Base Attack"
                cell.detailTextLabel?.text = "\(model.base_attack_min) - \(model.base_attack_max)"
            }
            return cell
        } else if indexPath.section == 4 {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
            cell.textLabel?.text = "Move Speed"
            cell.detailTextLabel?.text = String(Int(model.move_speed))
            return cell
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cell: UITableViewCell.self)
            cell.textLabel?.text = model.roles[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    // swiftlint:enable cyclomatic_complexity
}
