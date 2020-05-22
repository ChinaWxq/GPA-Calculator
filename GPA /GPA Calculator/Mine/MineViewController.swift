//
//  MineViewController.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit

/// 我的界面视图控制器
class MineViewController: UIViewController {

    // MARK: 视图
    
    // MARK: 方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    
    /// 初始化UI
    func setupView() {
        //self.navigationController?.delegate = self
        view.backgroundColor = .white
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
