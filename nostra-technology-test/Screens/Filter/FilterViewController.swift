//
//  FilterViewController.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 02/10/22.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    
    func onDismissViewController()
}

internal final class FilterViewController: ViewController {
    
    // MARK: - UI Properties
    
    private lazy var tableView = UITableView().then {
        $0.register(cell: UITableViewCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - FilterViewController Properties
    
    weak var delegate: FilterViewControllerDelegate?
    private var viewModel: FilterViewModel?
    
    init(viewModel: FilterViewModel) {
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
    
    private func setupView() {
        self.view.addSubviews(tableView)
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
}

extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = self.viewModel?.heroFilter else {
            return
        }
        
        UserDefaultConfig.heroFilter = model[indexPath.row]
        self.presentingViewController?.viewDidAppear(true)
        delegate?.onDismissViewController()
    }
}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = self.viewModel?.heroFilter else {
            return 0
        }
        
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel?.heroFilter[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: UITableViewCell.self)
        cell.accessoryType = UserDefaultConfig.heroFilter == model ? .checkmark : .none
        cell.textLabel?.text = model.rawValue
        return cell
    }
}
