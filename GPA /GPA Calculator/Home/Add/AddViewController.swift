//
//  AddViewController.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import UIKit
import Foundation

protocol AddViewDateScourceDelegate {
    func passValueToAddData(item: Course)
}

/// Home页添加课程视图控制器
class AddViewController: UIViewController {
    
    private var course: Course?
    
    var delegate: AddViewDateScourceDelegate?
    
    // MARK: 视图
    
    lazy var topLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "添加课程"
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var courseTermLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "学年"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var courseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "课程"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var courseCreditLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "学分"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var courseGradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.text = "成绩"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var topRightCloseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        return button
    }()
    
    lazy var rightCourseNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.returnKeyType = .go
        textField.clearButtonMode = .never
        return textField
    }()
    
    lazy var rightCourseCreditPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    lazy var rightCourseGradeTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        return textField
    }()
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: ScreenWidth * 0.1, y: ScreenHeight / 2 - ScreenWidth * 0.55, width: ScreenWidth * 0.8, height: ScreenWidth * 1.1))
        view.backgroundColor = .white
        view.layer.cornerRadius = 20.fit
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 0.3).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4.fit)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 12.fit
        return view
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.view.frame
        return effectView
    }()
    
    lazy var rightCourseTermSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: "大一", at: 0, animated: true)
        control.insertSegment(withTitle: "大二", at: 1, animated: true)
        control.insertSegment(withTitle: "大三", at: 2, animated: true)
        control.insertSegment(withTitle: "大四", at: 3, animated: true)
        control.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        control.selectedSegmentIndex = 0
        //control.tintColor = UIColor.init(red: 252/255.0, green:245/255.0, blue:248/255.0, alpha:1)
        return control
    }()
    
    lazy var courseGradeTextFieldView: UIView = {
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
    
    lazy var courseNameTextFieldView: UIView = {
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
    
    lazy var courseCreditPickerView: UIView = {
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
    
    lazy var bottomOKButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.init(hex: 0x03A9F4)
        button.setTitle("OK", for: .normal)
        button.layer.cornerRadius = 20.fit
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(clickOKButton), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: 方法
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        course = Course(term: .one, name: "", credit: 0, grade: 0)
        setupView()
        // Do any additional setup after loading the view.
    }
    
    /// 初始化UI
    func setupView() {
        view.backgroundColor = .clear
        view.addSubview(effectView)
        view.addSubview(backView)
        backView.addSubview(courseTermLabel)
        backView.addSubview(topLeftLabel)
        backView.addSubview(topRightCloseButton)
        backView.addSubview(courseNameLabel)
        backView.addSubview(courseCreditLabel)
        backView.addSubview(courseGradeLabel)
        courseNameTextFieldView.addSubview(rightCourseNameTextField)
        backView.addSubview(courseNameTextFieldView)
        courseGradeTextFieldView.addSubview(rightCourseGradeTextField)
        backView.addSubview(courseGradeTextFieldView)
        courseCreditPickerView.addSubview(rightCourseCreditPickerView)
        backView.addSubview(courseCreditPickerView)
        backView.addSubview(bottomOKButton)
        backView.addSubview(rightCourseTermSegmentControl)
        
        topLeftLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.top.equalToSuperview().offset(20.fit)
            maker.width.equalTo(200.fit)
            maker.height.equalTo(50.fit)
        }
        
        topRightCloseButton.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-15.fit)
            maker.top.equalToSuperview().offset(25.fit)
            maker.width.equalTo(38.fit)
            maker.height.equalTo(38.fit)
        }
        
        courseTermLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.top.equalTo(self.topLeftLabel.snp.bottom).offset(10.fit)
            maker.width.equalTo(200.fit)
            maker.height.equalTo(50.fit)
        }
        
        courseNameLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.top.equalTo(self.courseTermLabel.snp.bottom).offset(10.fit)
            maker.width.equalTo(200.fit)
            maker.height.equalTo(50.fit)
        }
        
        courseCreditLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.top.equalTo(self.courseNameLabel.snp.bottom).offset(10.fit)
            maker.width.equalTo(200.fit)
            maker.height.equalTo(50.fit)
        }
        
        courseGradeLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(20.fit)
            maker.top.equalTo(self.courseCreditLabel.snp.bottom).offset(10.fit)
            maker.width.equalTo(200.fit)
            maker.height.equalTo(50.fit)
        }
        
        
        
        courseNameTextFieldView.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-30.fit)
            maker.centerY.equalTo(self.courseNameLabel.snp.centerY)
            maker.height.equalTo(40.fit)
            maker.width.equalTo(180.fit)
        }
        
        
        courseGradeTextFieldView.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-30.fit)
            maker.centerY.equalTo(self.courseGradeLabel.snp.centerY)
            maker.height.equalTo(40.fit)
            maker.width.equalTo(180.fit)
        }
        
        courseCreditPickerView.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-30.fit)
            maker.centerY.equalTo(self.courseCreditLabel.snp.centerY)
            maker.width.equalTo(50.fit)
            maker.height.equalTo(50.fit)
        }
        
        rightCourseTermSegmentControl.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-30.fit)
            maker.centerY.equalTo(self.courseTermLabel.snp.centerY)
            maker.height.equalTo(40.fit)
            maker.width.equalTo(180.fit)
        }
        
        rightCourseCreditPickerView.snp.makeConstraints { (maker) in
            maker.right.bottom.equalToSuperview().offset(-5.fit)
            maker.left.top.equalToSuperview().offset(5.fit)
        }
        
        rightCourseNameTextField.snp.makeConstraints { (maker) in
            maker.right.bottom.equalToSuperview().offset(-10.fit)
            maker.left.top.equalToSuperview().offset(10.fit)
        }
        
        rightCourseGradeTextField.snp.makeConstraints { (maker) in
            maker.right.bottom.equalToSuperview().offset(-10.fit)
            maker.left.top.equalToSuperview().offset(10.fit)
        }
        
        bottomOKButton.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(-30.fit)
            maker.right.equalToSuperview().offset(-40.fit)
            maker.left.equalToSuperview().offset(40.fit)
            maker.height.equalTo(40.fit)
        }
        
        //注册键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    /// 键盘弹出通知
    /// - Parameter notification: 通知
    @objc func handleKeyBoardDidShow(notification: NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        
        let keyBoardBounds = (userInfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue
        let duration = (userInfo.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! NSNumber).doubleValue
        
        let deltaY = keyBoardBounds.size.height / 2
        
        let animations:(() -> Void) = {
            self.backView.transform = CGAffineTransform(translationX: 0,y: -deltaY)
        }
            
        if duration > 0 {
            let options = UIView.AnimationOptions.init(rawValue: UInt((userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
            

        print("键盘弹起")
    }
    
    /// 键盘收起监听
    /// - Parameter notification: 通知
    @objc func handleKeyBoardDidHide(notification: NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        
        let duration = (userInfo.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey) as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            self.backView.transform = CGAffineTransform.identity
        }
            
        if duration > 0 {
            let options = UIView.AnimationOptions.init(rawValue: UInt((userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
        
        print("键盘收起")
    }
    
    @objc func segmentControlChanged() {
        course?.term = Term.init(rawValue: rightCourseTermSegmentControl.selectedSegmentIndex)!
    }
    
    @objc func clickCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clickOKButton() {
        if let name = rightCourseNameTextField.text {
            course?.name = name
        }
        if let num = Int(rightCourseGradeTextField.text ?? "") {
            course?.grade = num
        }
        course?.credit = rightCourseCreditPickerView.selectedRow(inComponent: 0) + 1
        if course != nil {
            print(course!)
        }
        delegate?.passValueToAddData(item: course!)
        dismiss(animated: true, completion: nil)
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


// MARK: UITextFieldDelegate

extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}


extension AddViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.fit
    }
}

extension AddViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 50.fit, height: 50.fit))
        lable.textColor = .black
        lable.textAlignment = .center
        lable.font = UIFont.systemFont(ofSize: 20)
        lable.text = String(row + 1)
        return lable
    }
    
}