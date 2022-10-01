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
    }
}
