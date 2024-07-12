//
//  ForecastCollectionViewCell.swift
//  OpenWeather
//
//  Created by 아라 on 7/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class ForecastCollectionViewCell: UICollectionViewCell {
    static let identifier = "ForecastCollectionViewCell"
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "14시"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "34도"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        [timeLabel, weatherImageView, tempLabel].forEach {
            contentView.addSubview($0)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(12)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.horizontalEdges.centerX.equalToSuperview()
            make.bottom.equalTo(tempLabel.snp.top)
            make.height.equalTo(weatherImageView.snp.width)
        }
    }
    
    func configureCell(_ data: List) {
        let time = data.dtTxt.split(separator: " ")[1]
        let hour = time.split(separator: ":")[0]
        timeLabel.text = "\(hour)시"
        
        let urlString = "https://openweathermap.org/img/wn/\(data.weather.first?.icon ?? "")@2x.png"
        let url = URL(string: urlString)
        weatherImageView.kf.setImage(with: url)
        
        tempLabel.text = data.main.temp.formatted() + "º"
    }
}
