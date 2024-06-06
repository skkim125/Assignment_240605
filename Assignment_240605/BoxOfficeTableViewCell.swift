//
//  BoxOfficeTableViewCell.swift
//  Assignment_240605
//
//  Created by 김상규 on 6/6/24.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    lazy var rankingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(rankingLabel)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configureLayout() {
        
        rankingLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.snp.verticalEdges).inset(4)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(40)
            make.height.equalTo(36)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(rankingLabel.snp.verticalEdges)
            make.leading.equalTo(rankingLabel.snp.trailing).offset(12)
            make.height.equalTo(rankingLabel)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(rankingLabel.snp.verticalEdges)
            make.leading.equalTo(movieTitleLabel.snp.trailing).offset(20)
            make.trailing.equalTo(contentView.snp.trailing)
            make.width.equalTo(80)
            make.height.equalTo(rankingLabel)
        }
    }
    
    func setLabelTitle(data: DailyBoxOfficeInfo) {
        rankingLabel.text = data.rank
        movieTitleLabel.text = data.movieNm
        dateLabel.text = data.openDt
    }
}
