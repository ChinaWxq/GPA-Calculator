//
//  HomeViewController.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import SnapKit

let boxCellIdentifier = "boxCell"

/// Home界面视图控制器
class HomeViewController: UIViewController {
    
    /// 根据学期进行分类的字典
    
    // MARK: 视图
    
    /// 搜索视图
    lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    /// 搜索视图内部视图
    lazy var searchInteralView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 6
        return view
    }()
    
    /// 搜索框
    lazy var searchBar: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString.init(string: "搜索", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.returnKeyType = .go
        textField.delegate = self
        //textField.backgroundColor = .clear
        textField.clearButtonMode = .never
        return textField
    }()
    
    /// 搜索框旁按钮，不可交互
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search"), for: .normal)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    /// 集合视图
    lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.itemSize = CGSize(width: 165.fit, height: 100.fit)
        flowLayout.minimumLineSpacing = 10.fit
        flowLayout.minimumInteritemSpacing = 5.fit
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    /// 长条内部左边图像视图
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "purple")
        imageView.image = image
        return imageView
    }()
    
    /// 长条内部右边课程数目标签
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = String(courseData.count)
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    /// 长条内部底边备注标签
    lazy var leftBottomLabel: UILabel = {
        let label = UILabel()
        label.text = "全部"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return label
    }()
    
    /// 长条视图
    lazy var allCourseBoxView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 20.fit
        backView.layer.masksToBounds = false
        backView.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        backView.layer.shadowOpacity = 1
        backView.layer.shadowRadius = 12.fit
        return backView
    }()
    
    /// 底部按钮
    lazy var bottomAddBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "add"), for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 30.fit
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor(red: 0.43, green: 0.5, blue: 1, alpha: 0.3).cgColor
        btn.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        btn.layer.shadowOpacity = 1
        btn.layer.shadowRadius = 12.fit
        btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: 方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    
    
    /// 初始化UI
    func setupView() {
        view.backgroundColor = .white
        setupSearchBar()
        
        view.addSubview(collectionView)
        
        collectionView.register(BoxCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: boxCellIdentifier)
        collectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.searchView.snp.bottom).offset(10.fit)
            maker.left.equalTo(self.view.snp.left).offset(10.fit)
            maker.right.equalTo(self.view.snp.right).offset(-10.fit)
            maker.height.equalTo(220.fit)
        }
        setupAllCourseBoxView()
        
        view.addSubview(bottomAddBtn)
        bottomAddBtn.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.view.snp.bottom).offset(-40.fit)
            maker.right.equalTo(self.view).offset(-30.fit)
            maker.height.width.equalTo(60.fit)
        }
    }
    
    
    
    /// 按钮点击事件
    @objc func clickButton() {
        let addViewController = AddViewController()
        addViewController.delegate = self
        addViewController.modalPresentationStyle = .overCurrentContext
        present(addViewController, animated: true, completion: nil)
    }
    
    /// 初始化长条视图
    func setupAllCourseBoxView() {
        
        view.addSubview(allCourseBoxView)
        
        
        allCourseBoxView.snp.makeConstraints { (maker) in
            maker.top.equalTo(self.collectionView.snp.bottom).offset(10.fit)
            maker.left.equalTo(self.view.snp.left).offset(20.fit)
            maker.right.equalTo(self.view.snp.right).offset(-20.fit)
            maker.height.equalTo(100.fit)
        }
        
        allCourseBoxView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(15.fit)
            maker.height.equalTo(40.fit)
            maker.width.equalTo(40.fit)
        }
        
        allCourseBoxView.addSubview(leftBottomLabel)
        leftBottomLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(15.fit)
            maker.bottom.equalToSuperview().offset(-5.fit)
            maker.height.equalTo(45.fit)
            maker.width.equalTo(45.fit)
        }
        
        allCourseBoxView.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-10.fit)
            maker.centerY.equalTo(self.leftImageView.snp.centerY)
            maker.width.equalTo(50.fit)
            maker.height.equalTo(50.fit)
        }
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(clickLongBox))
        allCourseBoxView.addGestureRecognizer(gesture)
    }
    
    @objc func clickLongBox() {
        let detailViewController = DetailViewController()
        detailViewController.courses = courseData
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    /// 初始化搜索条
    func setupSearchBar() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (maker) in
            maker.left.equalTo(self.view.snp.left).offset(20.fit)
            maker.right.equalTo(self.view.snp.right).offset(-20.fit)
            maker.top.equalTo(self.view.snp.top).offset(44)
            maker.height.equalTo(80.fit)
        }
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20.fit)
            make.right.equalTo(self.view.snp.right).offset(-20.fit)
            make.top.equalTo(self.view.snp.top).offset(44)
            make.height.equalTo(80.fit)
        }
        searchView.addSubview(searchInteralView)
        searchInteralView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(20.fit)
            make.right.equalTo(self.view.snp.right).offset(-20.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(50.fit)
        }
        searchView.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(40.fit)
            make.right.equalTo(self.view.snp.right).offset(-20.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.height.equalTo(50.fit)
        }
        searchView.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.view.snp.right).offset(-40.fit)
            make.centerY.equalTo(self.searchView.snp.centerY)
            make.width.height.equalTo(30.fit)
        }
    }
    
    
    /// 视图即将呈现，隐藏导航条
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// 视图即将消失，显示导航条
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BoxCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "boxCell", for: indexPath) as! BoxCollectionViewCell
        cell.updateUI(with: indexPath.row , count: categoryData[indexPath.row]?.count ?? 0)
        return cell
    }
    
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.courses = categoryData[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}


// MARK: UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


// MARK: 自定义的AddViewDataSourceDelegate

extension HomeViewController: AddViewDateScourceDelegate {
    func passValueToAddData(item: Course) {
        if item.credit > 0 && item.grade > 0 && item.name != "" {
            courseData.append(item)
            categoryData = updateCategoryData()
            print(courseData.count)
            collectionView.reloadData()
            self.rightLabel.text = String(courseData.count)
        }
    }

}
