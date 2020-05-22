//
//  AddViewController.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/// Home页添加课程视图控制器
class AddViewController: UIViewController {

    /// 视图
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: ScreenWidth / 2 - 100, y: ScreenHeight / 2 - 50, width: 200, height: 100))
        label.text = "课程添加界面"
        label.textAlignment = .center
        return label
    }()
    
    /// 方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    /// 初始化UI
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(label)
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
