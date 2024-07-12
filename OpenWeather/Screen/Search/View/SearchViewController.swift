//
//  SearchViewController.swift
//  OpenWeather
//
//  Created by 아라 on 7/10/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    private lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = current
        search.obscuresBackgroundDuringPresentation = false
        
        return search
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    let current: String
    var completionHandler: ((City) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setLayout()
        setNavigation()
    }
    
    init(_ city: String) {
        current = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNavigation() {
        navigationItem.title = "도시 검색"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }

    func setLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

