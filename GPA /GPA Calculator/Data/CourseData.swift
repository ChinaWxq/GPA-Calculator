//
//  CourseData.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation
import UIKit



/// 大学学期类型 0 - 3
enum Term: Int {
    case one = 0
    case two = 1
    case three = 2
    case four = 3
    case all = 4
}

/// 课程结构体
struct Course {
    var term: Term
    var name: String
    var credit: Int
    var grade: Int
}

/// 课程数据
var courseData: [Course] = []

var categoryData = updateCategoryData()

func updateCategoryData() -> [Int: [Course]]? {
    return Dictionary(
        grouping: courseData,
        by: { $0.term.rawValue}
    )
}


func calculateGPA(allCourses: [Course]?) -> CGFloat {
    guard allCourses != nil else {
        return 0.0
    }
    guard allCourses!.count > 0 else {
        return 0.0
    }
    var allCourseGP: CGFloat = 0.0
    var allCourseCredit: CGFloat = 0.0
    // 绩点是评估学习成绩的一种方法，国内大部分高校通用的计算方法是：绩点=分数/10-5，学分绩点=学分*绩点=学分*（分数/10-5）（90分以上按90分计算）。
    for course in allCourses! {
        let temp = course.grade / 10 - 5
        let creditGP = course.credit * temp
        allCourseGP = allCourseGP + CGFloat(creditGP)
        allCourseCredit = allCourseCredit + CGFloat(course.credit)
    }
    return allCourseGP / allCourseCredit
}


func getData() {
    let plistPath = Bundle.main.path(forResource: "UserData", ofType: ".plist")
    let array: NSArray = NSArray(contentsOfFile: plistPath!)!
    for item in array {
        let data = item as! NSDictionary
        let name = data.value(forKey: "name") as! String
        let credit = data.value(forKey: "credit") as! Int
        let term = data.value(forKey: "term") as! Int
        let grade = data.value(forKey: "grade") as! Int
        let course = Course(term: Term(rawValue: term)!, name: name, credit: credit, grade: grade)
        courseData.append(course)
    }
}
