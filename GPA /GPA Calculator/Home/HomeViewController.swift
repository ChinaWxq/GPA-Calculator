//
//  HomeViewController.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let boxCellIdentifier = "boxCell"
fileprivate let longBoxCellIdentifier = "longBoxCell"
fileprivate let courseCellIdentifier = "courseCell"
/// Home界面视图控制器
class HomeViewController: UIViewController {
    
    /// 根据学期进行分类的字典
    
    let searchController = UISearchController(searchResultsController: SearchViewController())
    
    // MARK: 视图
    
    /// 短Cell集合视图
    lazy var shortCollectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.itemSize = CGSize(width: 165.fit, height: 72.fit)
        flowLayout.minimumLineSpacing = 15.fit
        flowLayout.minimumInteritemSpacing = 10.fit
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    /// 底部按钮
    lazy var bottomAddBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(UIColor(named: "buttonColor"), for: .normal)
        btn.backgroundColor = UIColor(named: "background")
        btn.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return btn
    }()
    
    
    // 长Cell集合
    lazy var longBoxCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.itemSize = CGSize(width: 345.fit, height: 72.fit)
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // 课程tableview
    lazy var coursesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "background")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: 方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    
    /// 初始化UI
    func setupView() {
        view.backgroundColor = UIColor(named: "background")
        navigationItem.hidesSearchBarWhenScrolling = false
        let resultsUpdater = SearchViewController()
        searchController.searchResultsUpdater = resultsUpdater
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "搜索"
        searchController.searchBar.scopeButtonTitles = ["全部", "大一", "大二", "大三", "大四"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // 短cell collectionView配置
        view.addSubview(shortCollectionView)
        shortCollectionView.register(BoxCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: boxCellIdentifier)
        shortCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(135.fit)
            maker.left.equalTo(self.view.snp.left).offset(15.fit)
            maker.right.equalTo(self.view.snp.right).offset(-15.fit)
            maker.height.equalTo(165.fit)
        }
        
        // 长cell collectionView配置
        view.addSubview(longBoxCollectionView)
        longBoxCollectionView.register(LongBoxCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: longBoxCellIdentifier)
        longBoxCollectionView.snp.makeConstraints { (maker) in
            maker.top.equalTo(shortCollectionView.snp.bottom).offset(10.fit)
            maker.left.equalTo(self.view.snp.left).offset(15.fit)
            maker.right.equalTo(self.view.snp.right).offset(-15.fit)
            maker.height.equalTo(75.fit)
        }
        
        view.addSubview(coursesTableView)
        coursesTableView.register(CourseTableViewCell.classForCoder(), forCellReuseIdentifier: courseCellIdentifier)
        coursesTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(longBoxCollectionView.snp.bottom).offset(5.fit)
            maker.left.equalTo(self.view.snp.left).offset(15.fit)
            maker.right.equalTo(self.view.snp.right).offset(-15.fit)
            maker.bottom.equalToSuperview().offset(-50.fit)
        }
        
        
        view.addSubview(bottomAddBtn)
        bottomAddBtn.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self.view.snp.bottom).offset(-40.fit)
            maker.right.equalTo(self.view).offset(-10.fit)
            maker.width.equalTo(80.fit)
            maker.height.equalTo(40.fit)
        }
    }
    
    
    
    /// 按钮点击事件
    @objc func clickButton() {
        let addViewController = AddViewController()
        addViewController.delegate = self
        addViewController.modalPresentationStyle = .overCurrentContext
        present(addViewController, animated: true, completion: nil)
    }
    
    
    
    /// 视图即将呈现，隐藏导航条
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func updateView() {
        categoryData = updateCategoryData()
        shortCollectionView.reloadData()
        longBoxCollectionView.reloadData()
        coursesTableView.reloadData()
    }
    
    /// 视图即将消失，显示导航条
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === shortCollectionView {
            let cell: BoxCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: boxCellIdentifier, for: indexPath) as! BoxCollectionViewCell
            cell.updateUI(with: indexPath.row , count: categoryData?[indexPath.row]?.count ?? 0)
            return cell
        }
        else {
            let cell: LongBoxCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: longBoxCellIdentifier, for: indexPath) as! LongBoxCollectionViewCell
            cell.updateUI(count: courseData.count)
            return cell
        }
    }
    
    
}

// MARK: UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === shortCollectionView {
            return 4
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView === shortCollectionView {
            let detailViewController = DetailViewController.init(type: Term.init(rawValue: indexPath.row)!, courses: categoryData?[indexPath.row])
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            let detailViewController = DetailViewController(type: .all, courses: courseData)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
        
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
            
            // plist存储写入逻辑
            let filePath: String = NSHomeDirectory() + "/Documents/test.plist"
            let array: NSMutableArray = NSMutableArray()
            // print(courseData)
            for item in courseData {
                let dictionary: NSMutableDictionary = [:]
                let name = item.name as NSString
                let term = item.term.rawValue as NSNumber
                let grade = item.grade as NSNumber
                let credit = item.credit as NSNumber
                dictionary.setValue(name, forKey: "name")
                dictionary.setValue(term, forKey: "term")
                dictionary.setValue(grade, forKey: "grade")
                dictionary.setValue(credit, forKey: "credit")
                array.add(dictionary)
            }
            array.write(toFile: filePath, atomically: false)
            
            coursesTableView.reloadData()
            shortCollectionView.reloadData()
        }
    }
    
}


extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // TODO
    }
}

// MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: courseCellIdentifier, for: indexPath) as! CourseTableViewCell
        cell.updateUI(course: courseData[indexPath.row])
        return cell
    }
    
    
}

// MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.fit
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 25.fit, y: 0, width: ScreenWidth, height: 60.fit))
        label.textColor = UIColor(named: "cellLabelColor")
        label.text = "我的课程"
        label.font = UIFont(name: semiboldFontName, size: titleFontSize)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.fit
    }
}
