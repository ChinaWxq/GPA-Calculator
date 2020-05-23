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
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = self.view.frame
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
        switch courses![0].term {
        case .one:
            title = "大一学年"
        case .two:
            title = "大二学年"
        case .three:
            title = "大三学年"
        case .four:
            title = "大四学年"
        }
        if courses?.count == courseData.count {
            title = "大学期间"
        }
        view.addSubview(tableView)
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: detailCellIdentifier)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UITableViewDelegate

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


// MARK: UITableViewDataSource

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath)
        cell.textLabel?.text = courses![indexPath.row].name
        cell.detailTextLabel?.text = String(courses![indexPath.row].credit)
        return cell
    }
    
    
}
