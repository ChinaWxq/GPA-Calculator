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
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "大一"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setShadow()
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
            imageName = "red"
            text = "大一"
        case 1:
            imageName = "green"
            text = "大二"
        case 2:
            imageName = "gray"
            text = "大三"
        case 3:
            imageName = "blue"
            text = "大四"
        default:
            imageName = "red"
            text = "大一"
        }
        leftImageView.image = UIImage(named: imageName)
        leftBottomLabel.text = text
        rightLabel.text = String(count)
        
    }
    
    /// 初始化设置UI
    func setupView() {
        addSubview(backView)
        backView.snp.makeConstraints{(make) in
            make.left.top.equalToSuperview().offset(10.fit)
            make.right.bottom.equalToSuperview().offset(-10.fit)
        }
        
        addSubview(leftImageView)
        
        leftImageView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(20.fit)
            maker.height.equalTo(40.fit)
            maker.width.equalTo(40.fit)
        }
        
        addSubview(leftBottomLabel)
        leftBottomLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.bottom.equalToSuperview().offset(-5.fit)
            maker.height.equalTo(40.fit)
            maker.width.equalTo(40.fit)
        }
        
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10.fit)
            maker.centerY.equalTo(self.leftImageView.snp.centerY)
            maker.width.equalTo(50.fit)
            maker.height.equalTo(50.fit)
        }
    }
    
    /// 设置阴影
    func setShadow(){
           self.backView.backgroundColor = .white
           self.backView.layer.cornerRadius = 20.fit
           self.backView.layer.masksToBounds = false
           self.backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
           self.backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
           self.backView.layer.shadowOpacity = 1
           self.backView.layer.shadowRadius = 12.fit
    }
}
