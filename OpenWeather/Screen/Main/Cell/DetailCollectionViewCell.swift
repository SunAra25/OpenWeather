//
//  DetailCollectionViewCell.swift
//  OpenWeather
//
//  Created by 아라 on 7/12/24.
//

import UIKit
import SnapKit

class DetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailCollectionViewCell"
    
    private let backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray3
        label.textAlignment = .left
        return label
    }()
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .label
        label.textAlignment = .left
        return label
    }()
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .left
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
        contentView.addSubview(backView)
        
        [titleLabel, dataLabel, unitLabel, optionLabel].forEach {
            backView.addSubview($0)
        }
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
         
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(16)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(16)
        }
        
        unitLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(18)
        }
        
        optionLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configureCell(_ data: WeatherDetail) {
        titleLabel.text = data.title
        dataLabel.text = data.data
        unitLabel.text = data.unit
        optionLabel.text = data.option
    }
}
