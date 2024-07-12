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
    private let viewModel = MainViewModel()
    
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
        view.delegate = self
        view.dataSource = self
        view.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        return view
    }()
    private let forecastFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal
        
        let width = UIScreen.main.bounds.width - 32
        let inset: CGFloat = 8
        let padding: CGFloat = 4
        let size = (width - inset * 2 - padding * 4) / 5
        
        layout.itemSize = CGSize(width: size, height: 140)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
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
    private lazy var forecastTableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.identifier)
        view.rowHeight = 60
        view.isScrollEnabled = false
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
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewAppear.value = ()
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
            make.height.equalTo(180)
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
        }
        
        dayForecastLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        forecastTableView.snp.makeConstraints { make in
            make.top.equalTo(dayForecastLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(300)
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
        
        listButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    func bind() {
        viewModel.outputCurrentInfo.bind { [weak self] data in
            guard let self, let data else { return }
            
            cityNameLabel.text = data.name
            tempLabel.text = data.main.temp.formatted()
            weatherDescriptionLabel.text = data.weather.first?.description
            tempDetailLabel.text = "최고 : \(data.main.tempMax)℃ | 최저 : \(data.main.tempMin)℃" 
        }
        
        viewModel.outputTimeForecastList.bind { [weak self] data in
            guard let self else { return }
            forecastCollectionView.reloadData()
        }
        
        viewModel.outputDayForecastList.bind { [weak self] data in
            guard let self else { return }
            forecastTableView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputTimeForecastList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath) as? ForecastCollectionViewCell else { return UICollectionViewCell() }
        let list = viewModel.outputTimeForecastList.value
        let data = list[indexPath.row]
        cell.configureCell(data)
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputDayForecastList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
        let list = viewModel.outputDayForecastList.value
        let data = list[indexPath.row]
        cell.configureCell(data)
        cell.selectionStyle = .none
        return cell
    }
}
