//
//  CourseTableViewCell.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/27.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(course: Course) {
        leftTopLabel.text = course.name
        leftBottomLabel.text = getTermStr(type: course.term)
    }
    
    lazy var leftTopLabel: UILabel = {
        let label = UILabel()
        label.text = "计算机网络"
        label.textAlignment = .left
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: mediumFontName, size: 20)
        return label
    }()
    
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "大一"
        label.textAlignment = .left
        label.textColor = UIColor(named: "cellLabelColor")
        label.font = UIFont.init(name: lightFontName, size: assistFontSize)
        return label
    }()
    
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "cellBackground")
        return view
    }()
    
    func setupView() {
        selectionStyle = .none
        contentView.backgroundColor = UIColor(named: "background")
        addSubview(backView)
        backView.addSubview(leftTopLabel)
        backView.addSubview(leftBottomLabel)
        backView.addSubview(rightImageView)
        
        backView.layer.cornerRadius = 15.fit
        backView.layer.masksToBounds = true
        
        backView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(3.fit)
            maker.right.bottom.equalToSuperview().offset(-3.fit)
        }
        
        leftTopLabel.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(8.fit)
            maker.height.equalTo(30.fit)
            maker.width.equalTo(100.fit)
        }
        
        leftBottomLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(8.fit)
            maker.bottom.equalToSuperview().offset(-3.fit)
            maker.height.equalTo(30.fit)
            maker.width.equalTo(80.fit)
        }
        
        rightImageView.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10.fit)
            maker.centerY.equalToSuperview()
            maker.height.width.equalTo(30.fit)
        }
    }
}
