//
//  ForecastTableViewCell.swift
//  OpenWeather
//
//  Created by 아라 on 7/12/24.
//

import UIKit
import SnapKit

class ForecastTableViewCell: UITableViewCell {
    static let identifier = "ForecastTableViewCell"
    
    private let weekendLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private let minimumTemLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .systemGray2
        label.textAlignment = .center
        return label
    }()
    private let maximumTemLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout() {
        [weekendLabel, weatherImageView, minimumTemLabel, maximumTemLabel].forEach {
            contentView.addSubview($0)
        }
        
        weekendLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
        
        minimumTemLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(weatherImageView.snp.trailing).offset(8)
            make.width.equalTo(100)
        }
        
        maximumTemLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureCell(_ data: DayForecast) {
        weekendLabel.text = data.weekend
        
        let urlString = "https://openweathermap.org/img/wn/\(data.icon ?? "")@2x.png"
        let url = URL(string: urlString)
        weatherImageView.kf.setImage(with: url)
        
        minimumTemLabel.text = "최저 " + data.minTemp.formatted() + "º"
        maximumTemLabel.text = "최고 " + data.maxTemp.formatted() + "º"
    }
}
