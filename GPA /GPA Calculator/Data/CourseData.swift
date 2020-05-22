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
}

/// 课程结构体
struct Course {
    var term: Term
    var name: String
    var credit: Int
    var grade: Int
}

/// 课程数据
var courseData = [
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .one, name: "计算机导论", credit: 4, grade: 99),
    Course(term: .two, name: "计算机操作系统", credit: 4, grade: 90),
    Course(term: .two, name: "计算机操作系统", credit: 4, grade: 90),
    Course(term: .two, name: "计算机操作系统", credit: 4, grade: 90),
    Course(term: .two, name: "计算机操作系统", credit: 4, grade: 90),
    Course(term: .two, name: "计算机操作系统", credit: 4, grade: 90),
    Course(term: .three, name: "计算机网络", credit: 4, grade: 89),
    Course(term: .three, name: "计算机网络", credit: 4, grade: 89),
    Course(term: .three, name: "计算机网络", credit: 4, grade: 89),
    Course(term: .four, name: "毕业设计", credit: 3, grade: 99),
]

/// 根据学期进行分类的字典
var categoryData: [Int : [Course]]{
    Dictionary(
        grouping: courseData,
        by: { $0.term.rawValue}
    )
}
