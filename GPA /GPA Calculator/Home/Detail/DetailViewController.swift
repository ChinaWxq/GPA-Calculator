//
//  DetailViewController.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/23.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

let detailCellIdentifier = "detailCell"

class DetailViewController: UIViewController {
    
    var courses: [Course]?
    
    var type: Term!
    
    init(type: Term, courses: [Course]?) {
        super.init(nibName: nil, bundle: nil)
        self.type = type
        self.courses = courses
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var topLeftCourseNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: semiboldFontName, size: titleFontSize)
        label.textAlignment = .left
        label.textColor = UIColor(named: "cellLabelColor")
        return label
    }()
    
    lazy var topRightCourseNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: semiboldFontName, size: titleFontSize)
        label.textAlignment = .right
        label.textColor = UIColor(named: "cellLabelColor")
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "background")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "background")
        switch type {
        case .one:
            title = "大一学年"
        case .two:
            title = "大二学年"
        case .three:
            title = "大三学年"
        case .four:
            title = "大四学年"
        default:
            title = "大学期间"
        }
        view.addSubview(topLeftCourseNumberLabel)
        view.addSubview(topRightCourseNumberLabel)
        topLeftCourseNumberLabel.text =  String(format: "总计:%2d门", courses?.count ?? 0)
        topRightCourseNumberLabel.text = String(format: "绩点:%4.1f", calculateGPA(allCourses: courses))
        topLeftCourseNumberLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(75.fit)
            maker.left.equalToSuperview().offset(20.fit)
            maker.width.equalTo(150.fit)
            maker.height.equalTo(60.fit)
        }
        topRightCourseNumberLabel.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(75.fit)
            maker.right.equalToSuperview().offset(-20.fit)
            maker.width.equalTo(150.fit)
            maker.height.equalTo(60.fit)
        }
        view.addSubview(tableView)
        tableView.register(DetailTableViewCell.classForCoder(), forCellReuseIdentifier: detailCellIdentifier)
        tableView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.right.equalToSuperview().offset(-20.fit)
            maker.top.equalTo(self.topRightCourseNumberLabel.snp.bottom).offset(5.fit)
            maker.bottom.equalToSuperview().offset(-30.fit)
        }
    }

}

// MARK: UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.fit
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            for (index, course) in courseData.enumerated() {
                if course.credit == courses![indexPath.row].credit && course.name == courses![indexPath.row].name {
                    courseData.remove(at: index)
                    courses?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    
                    // 修改plist数据
                    let filePath: String = NSHomeDirectory() + "/Documents/test.plist"
                    let array: NSMutableArray = NSMutableArray()
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
                    topLeftCourseNumberLabel.text =  String(format: "总计:%2d门", courses?.count ?? 0)
                    topRightCourseNumberLabel.text = String(format: "绩点:%4.1f", calculateGPA(allCourses: courses))
                    return
//                    array = NSMutableArray(contentsOfFile: plistPath!)!
//                    print(array)
                }
            }
        }
    }
}


// MARK: UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = courses?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as! DetailTableViewCell
        cell.updateUI(course: courses![indexPath.row])
        return cell
    }
    
}
