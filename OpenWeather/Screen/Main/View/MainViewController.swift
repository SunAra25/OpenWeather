//
//  MainViewController.swift
//  OpenWeather
//
//  Created by 아라 on 7/10/24.
//

import UIKit
import SnapKit
import MapKit

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
        view.clipsToBounds = true
        return view
    }()
    private let timeForecastLabel = {
        let label = UILabel()
        label.text = "3시간 간격의 일기예보"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private lazy var forecastCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.forecastFlowLayout)
        return view
    }()
    private let forecastFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private let dayForecastView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.clipsToBounds = true
        return view
    }()
    private let dayForecastLabel = {
        let label = UILabel()
        label.text = "5일 간의 일기예보"
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
    private let locationView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.clipsToBounds = true
        return view
    }()
    private let locationLabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let mapView = MKMapView()
    private lazy var detailCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.detailFlowLayout)
        return view
    }()
    private let detailFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setHierarchy()
        setConstraints()
    }

    func setHierarchy() {
        [scrollView, bottomView].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        
        [currentView, timeForecastView, dayForecastView, locationView, detailCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        [cityNameLabel, tempLabel, weatherDescriptionLabel, tempDetailLabel].forEach {
            currentView.addSubview($0)
        }
        
        [timeForecastLabel, forecastCollectionView].forEach {
            timeForecastView.addSubview($0)
        }
        
        [dayForecastLabel, forecastTableView].forEach {
            dayForecastView.addSubview($0)
        }
        
        [locationLabel, mapView].forEach {
            locationView.addSubview($0)
        }
        
        bottomView.addSubview(listButton)
    }
    
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        currentView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityNameLabel.snp.bottom).offset(8)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tempLabel.snp.bottom).offset(8)
        }
        
        tempDetailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(20)
        }
        
        timeForecastView.snp.makeConstraints { make in
            make.top.equalTo(currentView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(160)
        }
        
        timeForecastLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        forecastCollectionView.snp.makeConstraints { make in
            make.top.equalTo(timeForecastLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        dayForecastView.snp.makeConstraints { make in
            make.top.equalTo(timeForecastView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
        
        dayForecastLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(dayForecastLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        locationView.snp.makeConstraints { make in
            make.top.equalTo(dayForecastView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
        
        detailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(16)
            make.bottom.equalToSuperview().inset(40)
        }
        
        bottomView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view)
            make.top.equalTo(scrollView.snp.bottom)
        }
    }
}
