//
//  BoxCollectionViewCell.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import SnapKit

/// 盒子控件Cell
class BoxCollectionViewCell: UICollectionViewCell {
    
    // MARK: 视图
    
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "red")
        imageView.image = image
        return imageView
    }()
    
    lazy var rightTopLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textAlignment = .right
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: semiboldFontName, size: titleFontSize)
        return label
    }()
    
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "大一"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .gray
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
    ///   - with: 0-3Cell中第几个
    ///   - count: 0-3Cell对应的课程总数
    public func updateUI(with: Int, count: Int) {
        var imageName: String
        var text: String
        switch with {
        case 0:
            imageName = "blue"
            text = "大一"
        case 1:
            imageName = "orange"
            text = "大二"
        case 2:
            imageName = "gray"
            text = "大三"
        case 3:
            imageName = "red"
            text = "大四"
        default:
            imageName = "green"
            text = "大一"
        }
        leftImageView.image = UIImage(named: imageName)
        leftBottomLabel.text = text
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
