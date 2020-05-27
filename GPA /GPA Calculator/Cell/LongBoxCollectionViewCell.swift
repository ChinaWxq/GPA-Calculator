//
//  LongBoxCollectionViewCell.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/27.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class LongBoxCollectionViewCell: UICollectionViewCell {
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "green")
        imageView.image = image
        return imageView
    }()
    
    lazy var rightTopLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textAlignment = .right
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: semiboldFontName, size: titleFontSize)
        return label
    }()
    
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "所有"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: mediumFontName, size: assistFontSize)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 方法
    
    /// 更新UI界面
    /// - Parameters:
    ///   - count: 课程总数
    public func updateUI(count: Int) {
        rightTopLabel.text = String(count)
        
    }
    
    /// 初始化设置UI
    func setupView() {
        contentView.backgroundColor = UIColor(named: "cellBackground")
        
        contentView.layer.cornerRadius = 15.fit
        contentView.layer.masksToBounds = true
        
        addSubview(leftImageView)
        
        leftImageView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(10.fit)
            maker.height.equalTo(35.fit)
            maker.width.equalTo(35.fit)
        }
        
        addSubview(leftBottomLabel)
        leftBottomLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(10.fit)
            maker.bottom.equalToSuperview()
            maker.height.equalTo(35.fit)
            maker.width.equalTo(100.fit)
        }
        
        addSubview(rightTopLabel)
        rightTopLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10.fit)
            maker.centerY.equalTo(self.leftImageView.snp.centerY)
            maker.width.equalTo(40.fit)
            maker.height.equalTo(40.fit)
        }
    }
    
}
