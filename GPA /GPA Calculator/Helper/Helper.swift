//
//  Helper.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/24.
//  Copyright © 2020 Ryan. All rights reserved.
//

import Foundation
import UIKit

// 平面宽高
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height


// 字体
let lightFontName = "PingFangSC-Light"
let mediumFontName = "PingFangSC-Medium"
let semiboldFontName = "PingFangSC-Semibold"

// 字体大小
let navigationFontSize: CGFloat = 34
let titleFontSize: CGFloat = 28
let contenFontSize: CGFloat = 24
let assistFontSize: CGFloat = 18


// 备注
let textViewPlaceholer = "对本次考试的备注"

// 渐变

func gradientColor(grade: Double) -> [UIColor] {
    if 60 <= grade && grade < 70 {
        return [UIColor.init(hex: 0xf9957f), UIColor.init(hex: 0xf2f5d0)]
    } else if 70 <= grade && grade < 80 {
        return [UIColor.init(hex: 0x0c7bb3), UIColor.init(hex: 0xf2baeb)]
    } else if 80 <= grade && grade < 90 {
        return [UIColor.init(hex: 0xc973ff), UIColor.init(hex: 0xaebafb)]
    } else if 90 <= grade && grade < 100 {
        return [UIColor.init(hex: 0xef33b1), UIColor.init(hex: 0xf6e6bc)]
    } else {
        return [UIColor.init(hex: 0x9fa5d5), UIColor.init(hex: 0xe8f5c8)]
    }
}
