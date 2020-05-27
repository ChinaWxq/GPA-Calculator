//
//  DetailTableViewCell.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/24.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import KDCircularProgress

class DetailTableViewCell: UITableViewCell {
    
    let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateUI(course: Course) {
        leftTopLabel.text = course.name
        leftBottomLabel.text = String(course.credit) + "学分"
        rightPercentView.progressColors = gradientColor(grade: Double(course.grade))
        rightPercentView.progress = Double(course.grade) / 100.0 * 360
        rightLabel.text = String(course.grade)
    }
    
    // MARK: 视图
    
    lazy var leftTopLabel: UILabel = {
        let label = UILabel()
        label.text = "计算机网络"
        label.textAlignment = .left
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: lightFontName, size: titleFontSize)
        return label
    }()
    
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "3学分"
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: lightFontName, size: assistFontSize)
        return label
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "89"
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: mediumFontName, size: 18)
        return label
    }()
    
    lazy var rightPercentView: KDCircularProgress = {
        let progress = KDCircularProgress()
        progress.progressColors = [UIColor.init(hex: 0xccfbff), UIColor.init(hex: 0xef96c5)]
        progress.angle = 20
        progress.startAngle = 0.0
        progress.glowMode = .constant
        progress.roundedCorners = false
        progress.trackThickness = 0.8
        progress.trackColor = .white
        return progress
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellBackground")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        contentView.backgroundColor = UIColor(named: "background")
        selectionStyle = .none
        addSubview(backView)
        addSubview(leftTopLabel)
        backView.layer.cornerRadius = 15.fit
        backView.layer.masksToBounds = true
        backView.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview().offset(5.fit)
            maker.right.bottom.equalToSuperview().offset(-5.fit)
        }
        
        leftTopLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(15.fit)
            maker.left.equalToSuperview().offset(15.fit)
            maker.height.equalTo(30.fit)
            maker.width.equalTo(200.fit)
        }
        
        addSubview(leftBottomLabel)
        leftBottomLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15.fit)
            maker.bottom.equalToSuperview().offset(-10.fit)
            maker.height.equalTo(30.fit)
            maker.width.equalTo(80.fit)
        }
                
        
        rightPercentView.addSubview(rightLabel)
        addSubview(rightPercentView)
        rightPercentView.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10.fit)
            maker.centerY.equalToSuperview()
            maker.width.equalTo(70.fit)
            maker.height.equalTo(70.fit)
        }
        
        rightLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.width.equalTo(30.fit)
            maker.height.equalTo(30.fit)
        }
    }
}
