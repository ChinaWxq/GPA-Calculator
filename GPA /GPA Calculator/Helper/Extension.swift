//
//  Extension.swift
//  GPA Calculator
//
//  Created by Ryan on 2020/5/22.
//  Copyright © 2020 Ryan. All rights reserved.
//

/*
 扩展文件
 iPhone X的数据 375, 812
 */

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height

extension Double {
    var fit: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitW: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitH: CGFloat {
        return CGFloat(self/812.0) * UIScreen.main.bounds.width
    }
}
extension Int {
    var fit: Int {
        return Int(CGFloat(self)/375.0 * UIScreen.main.bounds.width)
    }
    var fitW: Int {
        return Int(CGFloat(self)/375.0 * UIScreen.main.bounds.width)
    }
    var fitH: Int {
        return Int(CGFloat(self)/812.0 * UIScreen.main.bounds.width)
    }
}
extension CGFloat {
    var fitScreen: CGFloat {
        return CGFloat(self/375.0 * UIScreen.main.bounds.size.width)
    }
    var fit: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitW: CGFloat {
        return CGFloat(self/375.0) * UIScreen.main.bounds.width
    }
    var fitH: CGFloat {
        return CGFloat(self/812.0) * UIScreen.main.bounds.width
    }
}
