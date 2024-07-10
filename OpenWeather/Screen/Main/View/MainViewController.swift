//
//  MainViewController.swift
//  OpenWeather
//
//  Created by 아라 on 7/10/24.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let currentView = UIView()
    private let cityNameLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let tempLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let weatherDescriptionLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let tempDetailLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let timeForecastView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    private let timeForecastLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private lazy var forecastCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        return view
    }()
    private let flowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private let dayForecastView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    private let dayForecastLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let forecastTableView = {
        let view = UITableView()
        return view
    }()
    private let bottomView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    private let listButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "list.bullet")
        config.baseForegroundColor = .label
        button.configuration = config
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
